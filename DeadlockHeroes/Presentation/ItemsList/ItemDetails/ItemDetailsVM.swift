//
//  ItemDetailsVM.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 10/10/2024.
//

import Foundation
import PromiseKit

// MARK: - ItemDetailsVMLogic
protocol ItemDetailsVMLogic {
    var item: Promise<Item> { get }
}

// MARK: - ItemDetailsVM
final class ItemDetailsVM: ItemDetailsVMLogic {
    @Inject private var fetchItemUseCase: FetchItemUseCaseLogic
    
    var item: Promise<Item>
    
    private var resolver: Resolver<Item>
    
    init(id: Int) {
        (item, resolver) = Promise<Item>.pending()
        fetchItem(id: id)
    }
}

// MARK: - Fetch Item
private extension ItemDetailsVM {
    func fetchItem(id: Int) {
        fetchItemUseCase.execute(with: id) { [weak self] result in
            switch result {
            case .success(let item):
                self?.resolver.fulfill(item)
            case .failure(let error):
                self?.resolver.reject(error)
            }
        }
    }
}
