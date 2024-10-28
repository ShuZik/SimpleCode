//
//  Store.swift
//  Camera POC
//
//  Created by ShuZik on 24.10.2024.
//

public protocol Store {
    
    associatedtype ActionType: Action
    func dispatch(action: ActionType)
}

