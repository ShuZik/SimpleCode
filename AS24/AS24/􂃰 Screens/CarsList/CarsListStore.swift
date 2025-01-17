//
//  CarsViewModel.swift
//  AS24
//
//  Created by ShuZik on 16.01.2025.
//

import Foundation
import Combine

final class CarsListStore: ObservableObject, Store {
    @Published private(set) var cars: [CarModel] = []
    @Published private(set) var selectedCar: CarModel? = nil
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
    
    func handle(action: CarsListAction) {
        switch action {
            case .loadCars:
                loadCars()
            case .selectCar(let car):
                selectCar(car)
        }
    }
}

fileprivate extension CarsListStore {
    func loadCars() {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1" {
            Task {
                let fetchedCars = await fetchCarsFromServer()
                await MainActor.run {
                    if let fetchedCars = fetchedCars {
                        self.cars = fetchedCars
                    }
                    
                    self.isLoading = false
                }
            }
        } else {
            self.cars = CarModel.mockCars
            self.isLoading = false
        }
    }
    
    func selectCar(_ car: CarModel?) {
        selectedCar = car
    }

    func fetchCarsFromServer() async -> [CarModel]? {
        do {
            return try await NetworkService.shared.fetchCars()
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to load cars: \(error.localizedDescription)"
            }
            return nil
        }
    }
}
