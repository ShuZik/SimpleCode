//
//  Dispatcher.swift
//  Camera POC
//
//  Created by ShuZik on 24.09.2024.
//

public protocol Dispatcher {

    associatedtype StateType
    func dispatch(action: StateType)
}
