//
//  CombineBinding.swift
//  CombineBinding
//
//  Created by Nikita Rodin on 14.11.22.
//

import Foundation
import Combine

public extension HasCancellables {
    /// convenience for making several bindings bound to object lifetime
    /// - Parameter b: collection of build blocks
    func bind(@BindingsBuilder _ bindings: () -> [Cancellable]) {
        bindings().forEach { $0.store(in: &cancellables) }
    }
    /// convenience for making several bindings bound to specified bag
    /// - Parameter b: collection of build blocks
    func bind(until bag: inout Set<AnyCancellable>, @BindingsBuilder _ bindings: () -> [Cancellable]) {
        bindings().forEach { $0.store(in: &bag) }
    }
}

/*
 streamlines bindings between view and viewModel
 note when binding to methods that you must have strong ownership of the method's parent object, i.e. don't bind to self

 example usage

 bind {
    loginButton.tapped ~> vm.loginTapped
    emailButton.tapped ~> vm.emailTapped
    tableView.modelSelected ~> { [weak self] _ in self?.tableView.reloadData() }
 }
 */

infix operator ~>

public func ~><O: Publisher, B: Subject>(_ lhs: O, _ rhs: B) -> Cancellable where O.Output == B.Output, O.Failure == B.Failure {
    lhs.receive(on: DispatchQueue.main)
        .subscribe(rhs)
}

public func ~><T, O: Publisher>(_ lhs: O, _ rhs: @escaping (T) -> Void) -> Cancellable where O.Output == T, O.Failure == Never {
    lhs.receive(on: DispatchQueue.main)
        .sink(receiveValue: rhs)
}

@resultBuilder
public struct BindingsBuilder {
    public static func buildBlock(_ components: Cancellable...) -> [Cancellable] {
        components
    }
}
