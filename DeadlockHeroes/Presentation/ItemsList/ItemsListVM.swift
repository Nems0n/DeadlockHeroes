//
//  ItemsListVM.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 10/10/2024.
//

import Foundation
import PromiseKit

// MARK: - ItemsListVMLogic
protocol ItemsListVMLogic {
    var items: Promise<[SectionedItems]> { get }
    var filteredItems: [SectionedItems] { get }
    var onItemsUpdated: (() -> Void)? { get }
    
    func inSearchMode(isActive: Bool, searchBarText: String) -> Bool
    func updateSearchController(searchBarText: String?)
}

// MARK: - Sectioned Items
struct SectionedItems {
    let type: Item.SlotType
    let items: [Item]
}

// MARK: - ItemsListVM
final class ItemsListVM: ItemsListVMLogic {
    @Inject private var fetchItemsUseCase: FetchItemsUseCaseLogic
    @Inject private var searchItemsUseCase: SearchItemsUseCaseLogic
    
    private(set) var items: Promise<[SectionedItems]>
    private(set) var filteredItems: [SectionedItems] = []
        
    private var resolver: Resolver<[SectionedItems]>
    
    var onItemsUpdated: (() -> Void)?
    
    init() {
        (items, resolver) = Promise<[SectionedItems]>.pending()
        fetchShopableItems()
    }
}

// MARK: - Fetch Items
private extension ItemsListVM {
    func fetchShopableItems() {
        fetchItemsUseCase.executeShopableItems { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let itemsResult):
                let sectionedItems = self.itemsToSectionedItems(itemsResult)
                self.resolver.fulfill(sectionedItems)
            case .failure(let error):
                self.resolver.reject(error)
            }
        }
    }
}


// MARK: - SearchBar related
extension ItemsListVM {
    func inSearchMode(isActive: Bool, searchBarText: String) -> Bool {
        return isActive && !searchBarText.isEmpty
    }
    
    func updateSearchController(searchBarText: String?) {
        self.filteredItems = items.value ?? []
        if let searchText = searchBarText?.lowercased() {
            guard !searchText.isEmpty else { self.onItemsUpdated?(); return }
            searchItemsUseCase.execute(query: .init(query: searchText)) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let items):
                    self.filteredItems = self.itemsToSectionedItems(items)
                    self.onItemsUpdated?()
                case .failure(let error):
                    print("Failure: \(error.localizedDescription)")
                    self.onItemsUpdated?()
                }
            }
        }
    }
}

// MARK: - Private methods
private extension ItemsListVM {
    func itemsToSectionedItems(_ items: [Item]) -> [SectionedItems] {
        let groupedItems = Dictionary(grouping: items) { $0.itemSlotType }
        let sectionedItems = groupedItems.compactMap { (slotType, items) -> SectionedItems? in
            guard let slotType else { return nil }
            let sortedItems = items.sorted { ($0.cost ?? 0) < ($1.cost ?? 0) }
            return SectionedItems(type: slotType, items: sortedItems)
        }
        return sectionedItems
    }
}
