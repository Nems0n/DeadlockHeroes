//
//  HeroesListVM.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 09/10/2024.
//

import Foundation
import PromiseKit

// MARK: - HeroesListViewModelLogic
protocol HeroesListVMLogic {
    var heroes: Promise<[Hero]> { get }
}

// MARK: - HeroesListViewModel
final class HeroesListVM: HeroesListVMLogic {
    @Inject private var fetchHeroesUseCase: FetchHeroesUseCaseLogic
    
    var heroes: Promise<[Hero]>
        
    private var resolver: Resolver<[Hero]>
    
    init() {
        (heroes, resolver) = Promise<[Hero]>.pending()
        fetchAllHeroes()
    }
}

// MARK: - Fetch Heroes
private extension HeroesListVM {
    func fetchAllHeroes() {
        fetchHeroesUseCase.execute { [weak self] result in
            switch result {
            case .success(let heroesResult):
                self?.resolver.fulfill(heroesResult)
            case .failure(let error):
                self?.resolver.reject(error)
            }
        }
    }
}
