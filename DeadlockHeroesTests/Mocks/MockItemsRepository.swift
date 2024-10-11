//
//  MockItemsRepository.swift
//  DeadlockHeroesTests
//
//  Created by Vlad Todorov on 11/10/2024.
//

import Foundation
@testable import DeadlockHeroes

final class MockItemsRepository: ItemsRepositoryLogic {
    var shouldReturnError = false
    var items: [ItemDTO] = [ItemDTO(name: "test name", className: "test class", description: nil, shopable: true, startTrained: true, image: "", cost: 1, id: 1, type: "", itemSlotType: "vitality")]
    
    @Inject var itemsStore: ItemsStoreLogic
    
    func fetchAllItems(completion: @escaping (Result<[Item], any Error>) -> Void) {
        let dataItems = items.map { $0.toDomain() }
        if shouldReturnError {
            completion(.failure(NSError(domain: "FetchItemsError", code: 1)))
        } else {
            completion(.success(dataItems))
        }
    }
    
    func fetchItem(by id: Int, completion: @escaping (Result<Item, any Error>) -> Void) {
        let item = items.first(where: { $0.id == id })?.toDomain()
        guard let item else {
            completion(.failure(CustomError.general("Fetch item failure")))
            return
        }
        completion(.success(item))
    }
    
    func fetchItems(with query: DeadlockHeroes.ItemQuery, completion: @escaping (Result<[Item], any Error>) -> Void) {
        let items = itemsStore.items.filter { item in
            guard let name = item.name?.lowercased() else {
                    return false
                }
            return name.contains(query.query.lowercased())
        }.map { $0.toDomain() }
        completion(.success(items))
    }
}
