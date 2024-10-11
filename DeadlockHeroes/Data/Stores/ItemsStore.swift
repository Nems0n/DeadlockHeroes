//
//  ItemsStore.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 10/10/2024.
//

import Foundation

protocol ItemsStoreLogic {
    var items: [ItemDTO] { get }
    
    func setItems(_ items: [ItemDTO])
}

final class ItemsStore: ItemsStoreLogic {
    private(set) var items: [ItemDTO] = []
    
    func setItems(_ items: [ItemDTO]) {
        self.items = items
    }
}
