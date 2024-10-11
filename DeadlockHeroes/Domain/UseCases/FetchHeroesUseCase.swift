//
//  FetchHeroesUseCase.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 09/10/2024.
//

import Foundation

protocol FetchHeroesUseCaseLogic {
    func execute(completion: @escaping (Result<[Hero], Error>) -> Void)
}

final class FetchHeroesUseCase: FetchHeroesUseCaseLogic {
    
    @Inject private var heroesRepository: HeroesRepositoryLogic
    
    func execute(completion: @escaping (Result<[Hero], Error>) -> Void) {
        heroesRepository.fetchAllHeroes(completion: completion)
    }
}

