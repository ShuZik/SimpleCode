//
//  CameraDispatch.swift
//  Camera POC
//
//  Created by ShuZik on 28.10.2024.
//

import Foundation

final class CameraDispatcher {
    
    private(set) var store: CameraStore?
    
    func register(store: CameraStore) {
        self.store = store
    }
    
    func dispatch(_ action: CameraAction) {
        guard let store = store else {
            fatalError("CameraDispatcher must registered store")
        }
        
        store.handleAction(action)
    }
}
