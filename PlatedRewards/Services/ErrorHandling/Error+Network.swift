//
//  Error+Network.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/9/24.
//

import Foundation

public enum NetworkError: Error, LocalizedError, Equatable {
    case invalidURL
    case invalidResponse
    case requestFailed(statusCode: Int)
    case dataConversionFailure
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "The response was invalid."
        case .requestFailed(let statusCode):
            return "Request failed with status code \(statusCode)."
        case .dataConversionFailure:
            return "Failed to convert the data."
        }
    }
    
    // Logging support to handle API errors
    public func logError() {
            switch self {
            case .invalidURL:
                LoggerHelper.apiLogger.error("\(self.errorDescription ?? "Invalid URL Error")")
            case .invalidResponse:
                LoggerHelper.apiLogger.error("\(self.errorDescription ?? "Invalid Response Error")")
            case .requestFailed(let statusCode):
                LoggerHelper.apiLogger.error("Request failed with status code \(statusCode, privacy: .public)")
            case .dataConversionFailure:
                LoggerHelper.apiLogger.error("\(self.errorDescription ?? "Data Conversion Failure Error")")
            }
        }
}
