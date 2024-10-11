//
//  DomainAssembly.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 09/10/2024.
//

import Foundation
import Swinject

final class DomainAssembly: Assembly {
    func assemble(container: Container) {
        container.register(FetchHeroesUseCaseLogic.self) { _ in
            FetchHeroesUseCase()
        }.inObjectScope(.container)
        
        container.register(FetchItemsUseCaseLogic.self) { _ in
            FetchItemsUseCase()
        }.inObjectScope(.container)
        
        container.register(FetchItemUseCaseLogic.self) { _ in
            FetchItemUseCase()
        }.inObjectScope(.container)
        
        container.register(SearchItemsUseCaseLogic.self) { _ in
            SearchItemsUseCase()
        }.inObjectScope(.container)
    }
}
