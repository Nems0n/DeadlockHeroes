//
//  DataAssemblyTests.swift
//  DeadlockHeroesTests
//
//  Created by Vlad Todorov on 11/10/2024.
//

import XCTest
import Swinject
@testable import DeadlockHeroes

// MARK: - ProviderAssemblyTests
final class ProviderAssemblyTests: XCTestCase {

    var container: Container!
    var assembly: DataAssembly!

    override func setUp() {
        super.setUp()
        container = Container()
        assembly = DataAssembly()
        assembly.assemble(container: container)
    }

    override func tearDown() {
        container = nil
        assembly = nil
        super.tearDown()
    }

    func testHeroesServiceIsRegistered() {
        let registration = container.resolve(HeroesServiceLogic.self)
        XCTAssertNotNil(registration, "registration should be resolved and not nil")
        XCTAssertTrue(registration is HeroesService, "Resolved instance should be of type HeroesServiceLogic")
   }
    
    func testHeroesRepositoryIsRegistered() {
        let registration = container.resolve(HeroesRepositoryLogic.self)
        XCTAssertNotNil(registration, "registration should be resolved and not nil")
        XCTAssertTrue(registration is HeroesRepository, "Resolved instance should be of type HeroesRepository")
   }
    
    func testItemsServiceIsRegistered() {
        let registration = container.resolve(ItemsServiceLogic.self)
        XCTAssertNotNil(registration, "registration should be resolved and not nil")
        XCTAssertTrue(registration is ItemsService, "Resolved instance should be of type ItemsService")
   }
    
    func testItemsRepositoryIsRegistered() {
        let registration = container.resolve(ItemsRepositoryLogic.self)
        XCTAssertNotNil(registration, "registration should be resolved and not nil")
        XCTAssertTrue(registration is ItemsRepository, "Resolved instance should be of type ItemsRepository")
   }
    
    func testItemsStoreIsRegistered() {
        let registration = container.resolve(ItemsStoreLogic.self)
        XCTAssertNotNil(registration, "registration should be resolved and not nil")
        XCTAssertTrue(registration is ItemsStore, "Resolved instance should be of type ItemsStore")
   }

   func testSingletonBehavior() {
       let firstInstance = container.resolve(HeroesServiceLogic.self) as? HeroesService
       let secondInstance = container.resolve(HeroesServiceLogic.self) as? HeroesService
       
       XCTAssertNotNil(firstInstance)
       XCTAssertNotNil(secondInstance)
       XCTAssertTrue(firstInstance === secondInstance, "Both instances should be the same (singleton)")
   }
}
