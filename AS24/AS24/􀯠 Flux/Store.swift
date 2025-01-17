//
//  Store.swift
//  AS24
//
//  Created by ShuZik on 16.01.2025.
//

public protocol Store {
    
    associatedtype ActionType: Action
    func handle(action: ActionType)
}

