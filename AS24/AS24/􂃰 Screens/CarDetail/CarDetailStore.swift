//
//  CarDetailStore.swift
//  AS24
//
//  Created by ShuZik on 17.01.2025.
//

import Combine

final class CarDetailStore: ObservableObject, Store {
    @Published private(set) var car: CarModel!
        
    func handle(action: CarDetailAction) {
        switch action {
            case .setCar(let car):
                setCar(car)
            case .callToSeller(let phone):
                callToSeller(phone)
        }
    }
}

private extension CarDetailStore {
    func setCar(_ car: CarModel) {
        self.car = car
    }
    
    func callToSeller(_ phone: String) {
        print("Calling to \(phone)")
    }
}


