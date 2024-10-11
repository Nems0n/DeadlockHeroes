//
//  Item.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 10/10/2024.
//

import Foundation

// MARK: - Item
public struct Item: Equatable, Identifiable {
    public let id: Int?
    let name: String?
    let className: String?
    let shopable: Bool?
    let startTrained: Bool?
    let image: String?
    let cost: Int?
    let type: String?
    let itemSlotType: SlotType?
    
    enum SlotType: String {
        case weapon
        case vitality
        case spirit
    }
}
