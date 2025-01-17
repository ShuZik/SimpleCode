//
//  CarListDispatcher.swift
//  AS24
//
//  Created by ShuZik on 16.01.2025.
//

import Combine

final class CarsListDispatcher: ObservableObject, Dispatcher {

    @Published private(set) var store: CarsListStore

    private var cancellables: Set<AnyCancellable> = []

    init(store: CarsListStore = CarsListStore()) {
        self.store = store
        bindings()
    }

    func dispatch(_ action: CarsListAction) {
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
