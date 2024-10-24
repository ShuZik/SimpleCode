//
//  Store.swift
//  FluxSwift
//
//  Created by ShuZik on 24.03.2024.
//

public protocol Store {
    
    associatedtype ActionType: Action
    func dispatch(action: ActionType)
}

