//
//  ItemsService.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 10/10/2024.
//

import Foundation
import PromiseKit

protocol ItemsServiceLogic {
    func fetchAllItems() -> Promise<[ItemDTO]>
}

final class ItemsService: ItemsServiceLogic {
    public func fetchAllItems() -> Promise<[ItemDTO]> {
        API.Items.allItems.promise()
    }
}

