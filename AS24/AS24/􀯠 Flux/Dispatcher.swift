//
//  Dispatcher.swift
//  AS24
//
//  Created by ShuZik on 16.01.2025.
//

public protocol Dispatcher {

    associatedtype ActionType: Action
    
    func dispatch(_ action: ActionType)
    func bindings()
}
