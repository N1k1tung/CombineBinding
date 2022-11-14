//
//  HasCancellables.swift
//  CombineBinding
//
//  Created by Nikita Rodin on 14.11.22.
//

import Combine

/// for objects with lifetime cancellables
protocol HasCancellables: AnyObject {
    var cancellables: Set<AnyCancellable> { get set }
}
