//
//  ItemDTO.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 10/10/2024.
//

import Foundation

// MARK: - ItemDTO
struct ItemDTO: Codable {
    let name, className: String?
    let description: String?
    let shopable, startTrained: Bool?
    let image: String?
    let cost, id: Int?
    let type: String?
    let itemSlotType: String?

    enum CodingKeys: String, CodingKey {
        case name
        case className = "class_name"
        case description
        case shopable
        case startTrained = "start_trained"
        case image
        case cost
        case id
        case type
        case itemSlotType = "item_slot_type"
    }
}
