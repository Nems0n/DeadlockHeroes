//
//  Items.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 10/10/2024.
//

import Foundation

// MARK: - Items
public extension API {
    enum Items: NetworkClient {
        case allItems
        
        public var request: URLRequest {
            switch self {
            case .allItems:
                return getRequest(with: .allItems, httpMethod: .GET)
            }
        }
    }
}
