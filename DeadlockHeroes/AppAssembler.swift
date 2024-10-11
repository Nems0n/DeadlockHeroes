//
//  AppAssembler.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 11/10/2024.
//

import Swinject

public final class AppAssembler {
    public static let shared = AppAssembler()
    private init() {}
    
    private var assembler: Assembler!
    var container = Container()
    
    public func clearAll() {
        container = .init()
        assembler = nil
    }
    
    public func configure(_ assemblies: Assembly...) {
        assembler = Assembler(assemblies, container: container)
    }
    
    public var resolver: Resolver {
        container.synchronize()
    }
}
