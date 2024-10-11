//
//  HeroService.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 05/10/2024.
//

import Foundation
import PromiseKit

protocol HeroesServiceLogic {
    func fetchAllHeroes() -> Promise<[HeroDTO]>
}

final class HeroesService: HeroesServiceLogic {
    public func fetchAllHeroes() -> Promise<[HeroDTO]> {
        API.Heroes.allHeroes.promise()
    }
}
