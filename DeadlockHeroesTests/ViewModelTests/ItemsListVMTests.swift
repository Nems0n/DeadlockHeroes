//
//  ItemsListVMTests.swift
//  DeadlockHeroesTests
//
//  Created by Vlad Todorov on 11/10/2024.
//

import XCTest
import Swinject
@testable import DeadlockHeroes

// MARK: - DomainAssemblyTests
final class ItemsListVMTests: XCTestCase {

    var sut: ItemsListVM!

    override func setUp() {
        AppAssembler.shared.configure(
            DomainAssembly(),
            MockDataAssembly()
        )
        super.setUp()
        sut = ItemsListVM()
    }

    override func tearDown() {
        sut = nil
        AppAssembler.shared.clearAll()
        super.tearDown()
    }

    func testItemsFetched() {
        let expaction = self.expectation(description: "Expected items not empty")
        sut.items
            .done { heroes in
                XCTAssertTrue(!heroes.isEmpty)
                expaction.fulfill()
            }
            .catch { error in
                XCTFail("Failed to fetch items: \(error)")
            }
        waitForExpectations(timeout: 1)
    }
    
    func testFilteredItemsFetched() {
        sut.updateSearchController(searchBarText: "test")
        XCTAssertTrue(!sut.filteredItems.isEmpty)
   }
    
    func testInSearchModeSuccess() {
        let inSearchMode = sut.inSearchMode(isActive: true, searchBarText: "test")
        XCTAssertTrue(inSearchMode)
    }
    
    func testInSearchModeFailure() {
        let inSearchModeOne = sut.inSearchMode(isActive: false, searchBarText: "test")
        let inSearchModeTwo = sut.inSearchMode(isActive: true, searchBarText: "")
        let inSearchModeThree = sut.inSearchMode(isActive: false, searchBarText: "")
        
        let inSearchMode = inSearchModeOne && inSearchModeTwo && inSearchModeThree
        XCTAssertFalse(inSearchMode)
    }
    
    func testUpdateSearchController() {
        let expectation = self.expectation(description: "Expected onItemsUpdated")
        sut.onItemsUpdated = {
            expectation.fulfill()
        }
        sut.updateSearchController(searchBarText: "test")
        waitForExpectations(timeout: 1)
    }
}

