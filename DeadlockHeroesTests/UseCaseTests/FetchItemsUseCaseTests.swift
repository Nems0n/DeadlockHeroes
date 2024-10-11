//
//  FetchItemsUseCaseTests.swift
//  DeadlockHeroesTests
//
//  Created by Vlad Todorov on 11/10/2024.
//

import Swinject
import XCTest
@testable import DeadlockHeroes

// MARK: - FetchItemsUseCaseTests
final class FetchItemsUseCaseTests: XCTestCase {
    
    var sut: FetchItemsUseCase!

    override func setUp() {
        AppAssembler.shared.configure(
            MockDataAssembly()
        )
        super.setUp()
        sut = FetchItemsUseCase()
    }

    override func tearDown() {
        sut = nil
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
