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
    var container: Container!

    override func setUp() {
        super.setUp()
        container = Container.shared
        
        container.register(HeroesRepositoryLogic.self) { _ in MockHeroesRepository() }
        
        sut = FetchHeroesUseCase()
    }

    override func tearDown() {
        sut = nil
        container = nil
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

