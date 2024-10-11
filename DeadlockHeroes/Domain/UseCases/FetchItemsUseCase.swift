//
//  FetchItemsUseCase.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 10/10/2024.
//

import Foundation

// MARK: - FetchItemsUseCaseLogic
protocol FetchItemsUseCaseLogic {
    func execute(completion: @escaping (Result<[Item], Error>) -> Void)
    func executeShopableItems(completion: @escaping (Result<[Item], Error>) -> Void)
}

// MARK: - FetchItemsUseCase
final class FetchItemsUseCase: FetchItemsUseCaseLogic {
    
    @Inject private var itemsRepository: ItemsRepositoryLogic
    
    func execute(completion: @escaping (Result<[Item], Error>) -> Void) {
        itemsRepository.fetchAllItems(completion: completion)
    }
    
    func executeShopableItems(completion: @escaping (Result<[Item], Error>) -> Void) {
        itemsRepository.fetchAllItems { result in
            switch result {
            case .success(let items):
                let shopableItems = items.filter { $0.shopable == true }
                completion(.success(shopableItems))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
