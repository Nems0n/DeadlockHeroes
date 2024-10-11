//
//  FetchItemUseCaseTests.swift
//  DeadlockHeroesTests
//
//  Created by Vlad Todorov on 11/10/2024.
//

import Foundation
import Swinject
import XCTest
@testable import DeadlockHeroes

// MARK: FetchItemUseCaseTests
final class FetchItemUseCaseTests: XCTestCase {
    
    var sut: FetchItemUseCase!

    override func setUp() {
        AppAssembler.shared.configure(
            MockDataAssembly()
        )
        super.setUp()
        sut = FetchItemUseCase()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testExecuteReturnsItems() {
        let id = 1
        sut.execute(with: id) { result in
            switch result {
            case .success(let item):
                XCTAssertEqual(item.id, id)
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }
    }
}
