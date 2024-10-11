//
//  HeroDTO.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 09/10/2024.
//

import Foundation

// MARK: - HeroDTO
struct HeroDTO: Decodable {
    let id: Int
    let className, name: String
    let playerSelectable, disabled, inDevelopment, needsTesting: Bool
    let complexity, readability: Int
    let collisionRadius, collisionHeight, stepHeight: Int
    let images: ImagesDTO
    
    private enum CodingKeys: String, CodingKey {
        case id
        case className = "class_name"
        case name
        case playerSelectable = "player_selectable"
        case disabled
        case inDevelopment = "in_development"
        case needsTesting = "needs_testing"
        case complexity
        case readability
        case collisionRadius = "collision_radius"
        case collisionHeight = "collision_height"
        case stepHeight = "step_height"
        case images
    }
}

// MARK: - ImagesDTO
extension HeroDTO {
    struct ImagesDTO: Decodable {
        let portrait, card, topBar, minimap: String?
        let small, weapon: String?
        
        private enum CodingKeys: String, CodingKey {
            case portrait
            case card
            case topBar = "top_bar"
            case minimap
            case small
            case weapon
        }
    }
}
