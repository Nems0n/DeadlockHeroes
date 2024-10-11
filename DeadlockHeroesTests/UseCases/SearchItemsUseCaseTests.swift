//
//  SearchItemsUseCaseTests.swift
//  DeadlockHeroesTests
//
//  Created by Vlad Todorov on 11/10/2024.
//

import Swinject
import XCTest
@testable import DeadlockHeroes

final class SearchItemsUseCaseTests: XCTestCase {
    
    var sut: SearchItemsUseCase!
    var container: Container!
    @Inject var repository: ItemsRepositoryLogic

    override func setUp() {
        super.setUp()
        container = Container.shared
        container.register(ItemsStoreLogic.self) { _ in MockItemsStore() }
        container.register(ItemsRepositoryLogic.self) { _  in MockItemsRepository() }
        
        sut = SearchItemsUseCase()
    }

    override func tearDown() {
        sut = nil
        container = nil
        super.tearDown()
    }

    func testExecuteWithQueryReturnsItems() {
        sut.execute(query: ItemQuery(query: "test")) { result in
            switch result {
            case .success(let items):
                XCTAssertTrue(!items.isEmpty)
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }
    }
}
