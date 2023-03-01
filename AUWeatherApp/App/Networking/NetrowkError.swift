//
//  NetrowkError.swift
//  AUWeatherApp
//
//  Created by Anand Upadhyay on 09/02/23.
//

import Foundation
protocol ErrorProtocol: LocalizedError {
    var title: String? { get }
    var code: Int { get }
}

struct NetworkError: ErrorProtocol {
    
    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    
    private var _description: String
    
    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
    }
}

enum Error: Swift.Error, LocalizedError {
    case badUrl
    case network
    case dataCorrupted
    case apiKeyIsMissing
    case other(String)
    
    var errorDescription: String? {
        localizedDescription
    }
    
    var localizedDescription: String {
        switch self {
        case .badUrl:
            return "Wrong city"
            
        case .network:
            return "Network error"
            
        case .dataCorrupted:
            return "Invalid data format"
            
        case .apiKeyIsMissing:
            return "Insert your API key"
            
        case .other(let message):
            return message
        }
    }
}
