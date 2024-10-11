//
//  Endpoints.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 10/10/2024.
//

import Foundation

public enum Endpoint {
    case allHeroes
    case allItems
    
    public var path: String {
        switch self {
        case .allHeroes:
            return "/v1/heroes"
        case .allItems:
            return "/v1/items"
        }
    }
}
