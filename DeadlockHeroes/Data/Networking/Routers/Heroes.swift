//
//  Heroes.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 05/10/2024.
//

import Foundation

// MARK: - Heroes
public extension API {
    enum Heroes: NetworkClient {
        case allHeroes
        
        public var request: URLRequest {
            switch self {
            case .allHeroes:
                return getRequest(with: .allHeroes, httpMethod: .GET)
            }
        }
    }
}
