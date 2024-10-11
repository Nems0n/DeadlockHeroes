//
//  SearchItemsUseCase.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 11/10/2024.
//

import Foundation

// MARK: - SearchItemsUseCaseLogic
protocol SearchItemsUseCaseLogic {
    func execute(query: ItemQuery, completion: @escaping (Result<[Item], Error>) -> Void)
}

// MARK: - SearchItemsUseCase
final class SearchItemsUseCase: SearchItemsUseCaseLogic {
    
    @Inject private var itemsRepository: ItemsRepositoryLogic
    
    func execute(query: ItemQuery, completion: @escaping (Result<[Item], Error>) -> Void) {
        itemsRepository.fetchItems(with: query) { result in
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
