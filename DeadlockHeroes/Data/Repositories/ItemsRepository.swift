//
//  ItemsRepository.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 10/10/2024.
//

import Foundation
import PromiseKit

public final class ItemsRepository: ItemsRepositoryLogic {
    
    @Inject private var itemsService: ItemsServiceLogic
    @Inject private var itemsStore: ItemsStoreLogic
    
    public func fetchAllItems(completion: @escaping (Swift.Result<[Item], Error>) -> Void) {
        itemsService.fetchAllItems()
            .map { [weak self] itemsDTOs in
                self?.itemsStore.setItems(itemsDTOs)
                return itemsDTOs.map({ $0.toDomain() })
            }
            .done { items in
                completion(.success(items))
            }
            .catch { error in
                completion(.failure(error))
            }
    }
    
    public func fetchItem(by id: Int, completion: @escaping (Swift.Result<Item, Error>) -> Void) {
        let item = itemsStore.items.first(where: { $0.id == id })?.toDomain()
        guard let item else {
            completion(.failure(CustomError.general("Fetch item failure")))
            return
        }
        completion(.success(item))
    }

    public func fetchItems(with query: ItemQuery, completion: @escaping (Swift.Result<[Item], any Error>) -> Void) {
        let items = itemsStore.items.filter { items in
            guard let name = items.name?.lowercased() else {
                    return false
                }
            return name.contains(query.query.lowercased())
        }.map { $0.toDomain() }
        completion(.success(items))
    }
}
