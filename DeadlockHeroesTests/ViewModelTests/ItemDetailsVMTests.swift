//
//  ItemDetailsVMTests.swift
//  DeadlockHeroesTests
//
//  Created by Vlad Todorov on 11/10/2024.
//

import XCTest
import Swinject
@testable import DeadlockHeroes

// MARK: - ItemDetailsVMTests
final class ItemDetailsVMTests: XCTestCase {

    var sut: ItemDetailsVM!
    var id: Int!

    override func setUp() {
        AppAssembler.shared.configure(
            DomainAssembly(),
            MockDataAssembly()
        )
        super.setUp()
        id = 1
        sut = ItemDetailsVM(id: id)
    }

    override func tearDown() {
        sut = nil
        id = nil
        AppAssembler.shared.clearAll()
        super.tearDown()
    }

    func testItemFetched() {
        let expaction = self.expectation(description: "Expected item not nil")
        sut.item
            .done { [weak self] item in
                XCTAssertEqual(item.id, self?.id)
                expaction.fulfill()
            }
            .catch { error in
                XCTFail("Failed to fetch heroes: \(error)")
            }
        waitForExpectations(timeout: 1)
   }
}


