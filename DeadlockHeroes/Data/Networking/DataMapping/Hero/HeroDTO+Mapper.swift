//
//  HeroDTO+Mapper.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 09/10/2024.
//

import Foundation

// MARK: - toDomain
extension HeroDTO {
    func toDomain() -> Hero {
        .init(id: id, className: className, name: name, playerSelectable: playerSelectable, disabled: disabled, inDevelopment: inDevelopment, needsTesting: needsTesting, complexity: complexity, readability: readability, collisionRadius: collisionRadius, collisionHeight: collisionHeight, stepHeight: stepHeight, images: images.toDomain())
    }
}

extension HeroDTO.ImagesDTO {
    func toDomain() -> Hero.Images {
        .init(portrait: portrait,
              card: card,
              topBar: topBar,
              minimap: minimap,
              small: small,
              weapon: weapon)
    }
}
