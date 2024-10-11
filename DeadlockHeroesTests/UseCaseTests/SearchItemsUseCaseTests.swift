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

    override func setUp() {
        AppAssembler.shared.configure(
            MockDataAssembly()
        )
        super.setUp()
        sut = SearchItemsUseCase()
    }

    override func tearDown() {
        sut = nil
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
