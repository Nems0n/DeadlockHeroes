//
//  MockDataAssembly.swift
//  DeadlockHeroesTests
//
//  Created by Vlad Todorov on 11/10/2024.
//

import Swinject
@testable import DeadlockHeroes

final class MockDataAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HeroesServiceLogic.self) { _ in
            HeroesService()
        }.inObjectScope(.container)
        
        container.register(HeroesRepositoryLogic.self) { _ in
            MockHeroesRepository()
        }.inObjectScope(.container)
        
        container.register(ItemsServiceLogic.self) { _ in
            ItemsService()
        }.inObjectScope(.container)
        
        container.register(ItemsRepositoryLogic.self) { _ in
            MockItemsRepository()
        }.inObjectScope(.container)
        
        container.register(ItemsStoreLogic.self) { _ in
            MockItemsStore()
        }.inObjectScope(.container)
    }
}
