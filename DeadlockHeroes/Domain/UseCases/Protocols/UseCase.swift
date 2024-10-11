//
//  UseCase.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 09/10/2024.
//

import Foundation

public protocol UseCase {
    @discardableResult
    func start() -> Cancellable?
}
