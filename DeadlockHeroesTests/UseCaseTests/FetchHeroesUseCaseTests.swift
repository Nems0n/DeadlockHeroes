//
//  FetchHeroesUseCaseTests.swift
//  DeadlockHeroesTests
//
//  Created by Vlad Todorov on 11/10/2024.
//

import Foundation
import Swinject
import XCTest
@testable import DeadlockHeroes

final class FetchHeroesUseCaseTests: XCTestCase {
    
    var sut: FetchHeroesUseCase!

    override func setUp() {
        AppAssembler.shared.configure(
            MockDataAssembly()
        )
        super.setUp()
        
        sut = FetchHeroesUseCase()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testExecuteReturnsHeroes() {
        sut.execute { result in
            switch result {
            case .success(let heroes):
                XCTAssertTrue(!heroes.isEmpty)
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }
        
    }

}

