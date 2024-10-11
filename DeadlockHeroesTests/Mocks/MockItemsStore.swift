//
//  MockItemsStore.swift
//  DeadlockHeroesTests
//
//  Created by Vlad Todorov on 11/10/2024.
//

import Foundation
@testable import DeadlockHeroes

final class MockItemsStore: ItemsStoreLogic {
    var items: [ItemDTO] = [ItemDTO(name: "test name", className: "test class", description: nil, shopable: true, startTrained: true, image: "", cost: 1, id: 1, type: "", itemSlotType: "vitality")]
    
    func setItems(_ items: [DeadlockHeroes.ItemDTO]) {
        self.items = items
    }
}
