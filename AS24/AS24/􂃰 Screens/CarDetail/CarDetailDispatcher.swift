//
//  CarDetailDispatcher.swift
//  AS24
//
//  Created by ShuZik on 17.01.2025.
//

//import Foundation
import Combine

final class CarDetailDispatcher: ObservableObject, Dispatcher {
    
    @Published private(set) var store: CarDetailStore
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(store: CarDetailStore = CarDetailStore()) {
        self.store = store
        bindings()
    }
    
    func dispatch(_ action: CarDetailAction) {
        store.handle(action: action)
    }
    
    func bindings() {
        store.objectWillChange
            .sink { [weak self] in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
}
