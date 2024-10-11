//
//  DataAssembly.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 09/10/2024.
//

import Foundation
import Swinject

final class DataAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HeroesServiceLogic.self) { _ in
            HeroesService()
        }.inObjectScope(.container)
        
        container.register(HeroesRepositoryLogic.self) { _ in
            HeroesRepository()
        }.inObjectScope(.container)
        
        container.register(ItemsServiceLogic.self) { _ in
            ItemsService()
        }.inObjectScope(.container)
        
        container.register(ItemsRepositoryLogic.self) { _ in
            ItemsRepository()
        }.inObjectScope(.container)
        
        container.register(ItemsStoreLogic.self) { _ in
            ItemsStore()
        }.inObjectScope(.container)
    }
}
