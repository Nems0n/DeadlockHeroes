//
//  HeroesListVMTests.swift
//  DeadlockHeroesTests
//
//  Created by Vlad Todorov on 11/10/2024.
//

import XCTest
import Swinject
@testable import DeadlockHeroes

// MARK: - HeroesLIstVMTests
final class HeroesListVMTests: XCTestCase {

    var sut: HeroesListVMLogic!

    override func setUp() {
        AppAssembler.shared.configure(
            DomainAssembly(),
            MockDataAssembly()
        )
        super.setUp()
        sut = HeroesListVM()
    }

    override func tearDown() {
        sut = nil
        AppAssembler.shared.clearAll()
        super.tearDown()
    }

    func testHeroesFetched() {
        let expaction = self.expectation(description: "Expected heroes not empty")
        sut.heroes
            .done { heroes in
                XCTAssertNotNil(heroes)
                expaction.fulfill()
            }
            .catch { error in
                XCTFail("Failed to fetch heroes: \(error)")
            }
        waitForExpectations(timeout: 1)
   }
}

