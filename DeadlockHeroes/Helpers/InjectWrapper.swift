//
//  InjectWrapper.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 09/10/2024.
//

import Foundation
import Swinject

@propertyWrapper
struct Inject<T> {
    private let name: String?
    
    init(_ name: String? = nil) {
        self.name = name
    }
    
    var wrappedValue: T {
        get {
            let resolved = AppAssembler.shared.container.resolve(T.self, name: name)
            assert(resolved != nil, "Dependency not found: \(String(describing: T.self)) \(String(describing: name))")
            return resolved!
        }
    }
}
