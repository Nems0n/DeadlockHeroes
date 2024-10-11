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
    var heroes: [Hero] = [Hero(id: 0, className: "testClass", name: "testName", playerSelectable: true, disabled: false, inDevelopment: false, needsTesting: false, complexity: 0, readability: 0, collisionRadius: 0, collisionHeight: 0, stepHeight: 0, images: Hero.Images(portrait: nil, card: nil, topBar: nil, minimap: nil, small: nil, weapon: nil))]

    func fetchAllHeroes(completion: @escaping (Result<[Hero], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "FetchHeroesError", code: 1, userInfo: nil)))
        } else {
            completion(.success(heroes))
        }
    }
}
