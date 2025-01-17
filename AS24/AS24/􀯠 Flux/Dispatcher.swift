//
//  Dispatcher.swift
//  AS24
//
//  Created by ShuZik on 16.01.2025.
//

public protocol Dispatcher {

    associatedtype StateType
    
    func dispatch(_ action: StateType)
    func bindings()
}
