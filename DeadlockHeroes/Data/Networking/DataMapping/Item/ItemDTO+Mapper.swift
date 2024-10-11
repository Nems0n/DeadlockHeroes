//
//  ItemDTO+Mapper.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 10/10/2024.
//

import Foundation

// MARK: - toDomain
extension ItemDTO {
    func toDomain() -> Item {
        .init(id: id, name: name, className: className, shopable: shopable, startTrained: startTrained, image: image, cost: cost, type: type, itemSlotType: Item.SlotType(rawValue: itemSlotType ?? ""))
    }
}
