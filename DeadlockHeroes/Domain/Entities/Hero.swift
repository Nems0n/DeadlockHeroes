//
//  Hero.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 09/10/2024.
//

import Foundation


// MARK: - Hero
public struct Hero: Equatable, Identifiable {
    public let id: Int
    let className, name: String
    let playerSelectable, disabled, inDevelopment, needsTesting: Bool
    let complexity, readability: Int
    let collisionRadius, collisionHeight, stepHeight: Int
    let images: Images
}

// MARK: - Images
extension Hero {
    struct Images: Equatable, Identifiable {
        let id: String = UUID().uuidString
        let portrait, card, topBar, minimap: String?
        let small, weapon: String?
    }
}

