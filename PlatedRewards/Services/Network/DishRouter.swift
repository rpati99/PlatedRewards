//
//  DishRouter.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/9/24.
//

import Foundation

enum DishRouter: URLRequestConvertible {
    case fetchDishes(category: String?, area: String?)
    case fetchCategories
    case fetchAreas
    case fetchDishInfo(id: String)
    
    // Define the API endpoints based on the request type.
    var endpoint: String {
        switch self {
        case .fetchDishes:
            return "/filter.php"
        case .fetchCategories:
            return "/list.php?c=list"
        case .fetchAreas:
            return "/list.php?a=list"
        case .fetchDishInfo:
            return "/lookup.php"
        }
    }
    
    // Define the HTTP method (GET for all operations here).
    var method: HTTPMethod {
        return .get
    }
    
    // Optional headers for the request
    var headers: [String: String] {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
    
    // Optional query parameters for the request
    var queryParameters: [URLQueryItem]? {
        switch self {
        case .fetchDishes(let category, let area):
            var queryItems = [URLQueryItem]()
            if let category = category, !category.isEmpty {
                queryItems.append(URLQueryItem(name: "c", value: category))
            }
            if let area = area, !area.isEmpty {
                queryItems.append(URLQueryItem(name: "a", value: area))
            }
            return queryItems.isEmpty ? nil : queryItems
        case .fetchDishInfo(let id):
            return [URLQueryItem(name: "i", value: id)]
        case .fetchCategories, .fetchAreas:
            return nil
        }
    }

    // Create the URLRequest using the base API URL and the endpoint.
    func makeURLRequest() throws -> URLRequest {
        guard var urlComponents = URLComponents(string: APIConfig.baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        // Add query parameters if present
        if let queryParameters = queryParameters {
            urlComponents.queryItems = queryParameters
        }
        
        guard let finalURL = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        // Create the URLRequest
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        
        // Add headers
        for (headerField, headerValue) in headers {
            request.setValue(headerValue, forHTTPHeaderField: headerField)
        }
        
        return request
    }
}
