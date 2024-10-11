//
//  HeroesRepository.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 09/10/2024.
//

import Foundation

public protocol HeroesRepositoryLogic {
    func fetchAllHeroes(completion: @escaping (Result<[Hero], Error>) -> Void)
}
