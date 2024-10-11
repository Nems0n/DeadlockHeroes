//
//  ItemsRepositoryLogic.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 10/10/2024.
//

import Foundation

public protocol ItemsRepositoryLogic {
    func fetchAllItems(completion: @escaping (Result<[Item], Error>) -> Void)
    func fetchItem(by id: Int, completion: @escaping (Result<Item, Error>) -> Void)
    func fetchItems(with query: ItemQuery, completion: @escaping (Result<[Item], Error>) -> Void)
}
