//
//  FetchItemsUseCaseTests.swift
//  DeadlockHeroesTests
//
//  Created by Vlad Todorov on 11/10/2024.
//

import Swinject
import XCTest
@testable import DeadlockHeroes

final class FetchItemsUseCaseTests: XCTestCase {
    
    var sut: FetchItemsUseCase!
    var container: Container!

    override func setUp() {
        super.setUp()
        container = Container.shared
        container.register(ItemsRepositoryLogic.self) { _  in MockItemsRepository() }
        
        sut = FetchItemsUseCase()
    }

    override func tearDown() {
        sut = nil
        container = nil
        super.tearDown()
    }

    func testExecuteReturnsItems() {
        sut.execute { result in
            switch result {
            case .success(let items):
                XCTAssertTrue(!items.isEmpty)
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }
    }
    
    func testExecuteShopableReturnsItems() {
        sut.executeShopableItems { result in
            switch result {
            case .success(let items):
                XCTAssertTrue(!items.isEmpty)
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }
    }
}
