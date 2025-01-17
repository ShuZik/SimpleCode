//
//  CarsListStoreTests.swift
//  AS24Tests
//
//  Created by ShuZik on 17.01.2025.
//

import XCTest
@testable import AS24

final class CarsListStoreTests: XCTestCase {
    
    var store: CarsListStore!
    var dispatcher: CarsListDispatcher!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        NetworkService.shared = mockNetworkService
        store = CarsListStore()
        dispatcher = CarsListDispatcher(store: store)
    }

    override func tearDown() {
        store = nil
        mockNetworkService = nil
        dispatcher = nil
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertTrue(store.cars.isEmpty)
        XCTAssertFalse(store.isLoading)
        XCTAssertNil(store.errorMessage)
        XCTAssertNil(store.selectedCar)
    }

    func testLoadCarsSuccess() async throws {
        mockNetworkService.shouldReturnError = false
        let expectation = XCTestExpectation(description: "Cars loaded successfully")

        store.$cars
            .dropFirst() // Drop initial value to avoid triggering with default state
            .sink { cars in
                XCTAssertEqual(cars.count, MockNetworkService.mockCars.count)
                XCTAssertEqual(cars.first?.make, "Mock Volvo")
                XCTAssertEqual(cars.first?.model, "XC90")
                expectation.fulfill()
            }
            .store(in: &mockNetworkService.cancellables)

        // Act: Load cars
        dispatcher.dispatch(.loadCars)

        // Wait for the expectation to be fulfilled
        await fulfillment(of: [expectation], timeout: 2.0)
    }

    func testIsLoadingFlag() async throws {
        let expectation1 = XCTestExpectation(description: "isLoading set to true initially")
        let expectation2 = XCTestExpectation(description: "isLoading set to false after completion")

        var isLoadingStates: [Bool] = []

        store.$isLoading
            .dropFirst() // Drop initial value to avoid triggering with default state
            .sink { isLoading in
                isLoadingStates.append(isLoading)
                if isLoadingStates == [true, false] {
                    expectation1.fulfill()
                    expectation2.fulfill()
                }
            }
            .store(in: &mockNetworkService.cancellables)

        // Act: Load cars
        dispatcher.dispatch(.loadCars)

        // Wait for the expectation to be fulfilled
        await fulfillment(of: [expectation1, expectation2], timeout: 2.0)
    }

    func testSelectCar() {
        // Arrange: Use a mock car from the mockCars array
        let car = CarModel.mockCar

        // Act: Dispatch selectCar action
        dispatcher.dispatch(.selectCar(car))

        // Assert: Ensure the selected car is set correctly
        XCTAssertEqual(store.selectedCar, car)
    }

    func testDeselectCar() {
        // Arrange: First, select a car from the mock cars
        let car = CarModel.mockCar
        dispatcher.dispatch(.selectCar(car))
        
        // Act: Deselect the car by dispatching a new action (nil)
        dispatcher.dispatch(.selectCar(nil))
        
        // Assert: Ensure the selected car is nil after deselection
        XCTAssertNil(store.selectedCar)
    }
}
