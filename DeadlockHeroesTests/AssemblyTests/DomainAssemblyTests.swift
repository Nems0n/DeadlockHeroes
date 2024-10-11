//
//  DomainAssemblyTests.swift
//  DeadlockHeroesTests
//
//  Created by Vlad Todorov on 11/10/2024.
//

import XCTest
import Swinject
@testable import DeadlockHeroes

// MARK: - DomainAssemblyTests
final class DomainAssemblyTests: XCTestCase {

    var container: Container!
    var assembly: DomainAssembly!

    override func setUp() {
        super.setUp()
        container = Container()
        assembly = DomainAssembly()
        assembly.assemble(container: container)
    }

    override func tearDown() {
        container = nil
        assembly = nil
        super.tearDown()
    }

    func testFetchHeroesUseCaseIsRegistered() {
        let registration = container.resolve(FetchHeroesUseCaseLogic.self)
        XCTAssertNotNil(registration, "registration should be resolved and not nil")
        XCTAssertTrue(registration is FetchHeroesUseCase, "Resolved instance should be of type FetchHeroesUseCaseLogic")
   }
    
    func testFetchItemsUseCaseIsRegistered() {
        let registration = container.resolve(FetchItemsUseCaseLogic.self)
        XCTAssertNotNil(registration, "registration should be resolved and not nil")
        XCTAssertTrue(registration is FetchItemsUseCase, "Resolved instance should be of type FetchItemsUseCase")
   }
    
    func testFetchItemUseCaseIsRegistered() {
        let registration = container.resolve(FetchItemUseCaseLogic.self)
        XCTAssertNotNil(registration, "registration should be resolved and not nil")
        XCTAssertTrue(registration is FetchItemUseCase, "Resolved instance should be of type FetchItemUseCase")
   }
    
    func testSearchItemsUseCaseIsRegistered() {
        let registration = container.resolve(SearchItemsUseCaseLogic.self)
        XCTAssertNotNil(registration, "registration should be resolved and not nil")
        XCTAssertTrue(registration is SearchItemsUseCase, "Resolved instance should be of type SearchItemsUseCase")
   }

   func testSingletonBehavior() {
       let firstInstance = container.resolve(FetchHeroesUseCaseLogic.self) as? FetchHeroesUseCase
       let secondInstance = container.resolve(FetchHeroesUseCaseLogic.self) as? FetchHeroesUseCase
       
       XCTAssertNotNil(firstInstance)
       XCTAssertNotNil(secondInstance)
       XCTAssertTrue(firstInstance === secondInstance, "Both instances should be the same (singleton)")
   }
}

