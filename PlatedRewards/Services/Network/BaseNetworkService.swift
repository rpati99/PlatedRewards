//
//  BaseNetworkService.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/9/24.
//

import Foundation

class BaseNetworkService<Router: URLRequestConvertible> {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    private func handleResponse(data: Data, response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
        }
    }
    
    // Generic request with Result<T, NetworkError> error handling
    func request<T: Decodable>(_ returnType: T.Type, router: Router) async -> Result<T, NetworkError> {
        do {
            let request = try router.makeURLRequest()
            let (data, response) = try await urlSession.data(for: request)
            
            try handleResponse(data: data, response: response)
            
            guard !data.isEmpty else {
                return .failure(.dataConversionFailure)
            }
            
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(returnType, from: data)
                return .success(decodedData)
            } catch {
                return .failure(.dataConversionFailure)
            }
        } catch {
            return .failure((error as? NetworkError) ?? .invalidResponse)
        }
    }
}
