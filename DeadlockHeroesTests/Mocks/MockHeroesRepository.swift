//
//  MockHeroesRepository.swift
//  DeadlockHeroesTests
//
//  Created by Vlad Todorov on 11/10/2024.
//

import Foundation
@testable import DeadlockHeroes

final class MockHeroesRepository: HeroesRepositoryLogic {
    var shouldReturnError = false
    var heroesDto: [HeroDTO] = [HeroDTO(id: 0, className: "testClass", name: "testName", playerSelectable: true, disabled: false, inDevelopment: false, needsTesting: false, complexity: 0, readability: 0, collisionRadius: 0, collisionHeight: 0, stepHeight: 0, images: HeroDTO.ImagesDTO(portrait: nil, card: nil, topBar: nil, minimap: nil, small: nil, weapon: nil))]

    func fetchAllHeroes(completion: @escaping (Result<[Hero], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "FetchHeroesError", code: 1, userInfo: nil)))
        } else {
            let heroes = heroesDto.map( {$0.toDomain()} )
            completion(.success(heroes))
        }
    }
}
