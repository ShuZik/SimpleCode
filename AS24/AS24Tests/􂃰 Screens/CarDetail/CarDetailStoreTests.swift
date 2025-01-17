//
//  CarDetailStoreTests.swift
//  AS24Tests
//
//  Created by ShuZik on 17.01.2025.
//

import XCTest
@testable import AS24

final class CarDetailStoreTests: XCTestCase {
    
    var store: CarDetailStore!
    var dispatcher: CarDetailDispatcher!
    
    override func setUp() {
        super.setUp()
        store = CarDetailStore()  // Initialize the Store
        dispatcher = CarDetailDispatcher(store: store)  // Initialize the Dispatcher
    }

    override func tearDown() {
        store = nil
        dispatcher = nil
        super.tearDown()
    }

    func testInitialStateWithMockCar() {
        // Arrange: Dispatch action to set car data
        dispatcher.dispatch(.setCar(CarModel.mockCar))
        
        // Assert: Check if the car data is set correctly
        XCTAssertEqual(store.car.make, "Mock Volvo")
        XCTAssertEqual(store.car.model, "XC90")
        XCTAssertEqual(store.car.price, 19500)
        XCTAssertEqual(store.car.seller?.phone, "(073) 555 44 33")
        XCTAssertEqual(store.car.seller?.city, "Kyiv")
        XCTAssertEqual(store.car.description, "Great condition, one owner, no accidents.")
        XCTAssertNotNil(store.car.images)
        XCTAssertEqual(store.car.images?.count, 3)
    }

    func testInitialStateWithMockCarNoImage() {
        // Arrange: Dispatch action to set a car without images
        dispatcher.dispatch(.setCar(CarModel.mockCarNoImage))
        
        // Assert: Check if the car data is set correctly without images
        XCTAssertEqual(store.car.make, "Mock Ford")
        XCTAssertEqual(store.car.model, "Mustang")
        XCTAssertEqual(store.car.price, 19500)
        XCTAssertEqual(store.car.seller?.phone, "(073) 555 44 33")
        XCTAssertEqual(store.car.seller?.city, "Kyiv")
        XCTAssertEqual(store.car.description, "Great condition, one owner, no accidents.")
        XCTAssertNil(store.car.images)
    }
}
