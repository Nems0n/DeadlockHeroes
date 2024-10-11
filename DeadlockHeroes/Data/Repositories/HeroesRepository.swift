//
//  HeroesRepository.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 09/10/2024.
//

import Foundation
import PromiseKit

public final class HeroesRepository: HeroesRepositoryLogic {
    
    @Inject private var heroesService: HeroesServiceLogic
    
    public func fetchAllHeroes(completion: @escaping (Swift.Result<[Hero], Error>) -> Void) {
        heroesService.fetchAllHeroes()
            .map { heroesDTOs in
                heroesDTOs.map({ $0.toDomain() })
            }
            .done { heroes in
                completion(.success(heroes))
            }
            .catch { error in
                completion(.failure(error))
            }
    }
}
