//
//  Untitled.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 05/10/2024.
//

import Foundation

public enum API {
    static func getURL(with path: String = "" ) -> URL {
        return URL(string: "https://assets.deadlock-api.com\(path)")!
    }
    
    static func getHeaders() -> [String: String] {
        let headers: [String: String] = ["Content-Type": "application/json"]
        return headers
    }
}
