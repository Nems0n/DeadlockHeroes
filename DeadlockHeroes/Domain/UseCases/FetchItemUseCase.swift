//
//  FetchItemUseCase.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 10/10/2024.
//

import Foundation

// MARK: - FetchItemUseCaseLogic
protocol FetchItemUseCaseLogic {
    func execute(with id: Int, completion: @escaping (Result<Item, Error>) -> Void)
}

// MARK: - FetchItemUseCase
final class FetchItemUseCase: FetchItemUseCaseLogic {
    
    @Inject private var itemsRepository: ItemsRepositoryLogic
    
    func execute(with id: Int, completion: @escaping (Result<Item, Error>) -> Void) {
        itemsRepository.fetchItem(by: id, completion: completion)
    }
}
