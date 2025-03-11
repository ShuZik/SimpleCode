//
//  CarsListViewUITests.swift
//  AS24UITests
//
//  Created by ShuZik on 16.01.2025.
//

import XCTest

final class CarsListViewUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("XCODE_RUNNING_UITEST")
        app.launch()
    }
    
    func testCarsList_Load() throws {
        XCTAssertTrue(app.staticTexts["Cars"].exists)
    }

    func testCarsList_LoadsAndDisplaysCars() throws {
        let carsListView = app.collectionViews["CarsListView"]
        XCTAssertTrue(carsListView.waitForExistence(timeout: 5), "Cars list should be displayed")

        let firstCarCell = app.cells.firstMatch
        XCTAssertTrue(firstCarCell.waitForExistence(timeout: 5), "First car cell should appear in the list")

        let carMakeModel = firstCarCell.staticTexts.firstMatch
        XCTAssertTrue(carMakeModel.exists, "Car make and model should be displayed")

        let carPrice = firstCarCell.staticTexts.containing(NSPredicate(format: "label CONTAINS '$'")).firstMatch
        XCTAssertTrue(carPrice.exists, "Car price should be displayed")

        let carImage = firstCarCell.images.firstMatch
        XCTAssertTrue(carImage.exists, "Car image should be displayed")
    }

    func testSelectingCar_NavigatesToDetailView() throws {
        let firstCarCell = app.cells.
        XCTAssertTrue(firstCarCell.waitForExistence(timeout: 5), "First car cell should appear in the list")

        firstCarCell.tap()
        
        firstCarCell.debugDescription

        sleep(2)

        let car = app.staticTexts["Mock Volvo"]
        XCTAssertTrue(car.waitForExistence(timeout: 5), "Car detail view should be displayed")
    }

    func testBackNavigation_ReturnsToCarsList() throws {
        let carsListView = app.collectionViews["CarsListView"]
        XCTAssertTrue(carsListView.waitForExistence(timeout: 5), "Cars list should be displayed")
        
        let firstCarCell = app.cells.firstMatch
        XCTAssertTrue(firstCarCell.waitForExistence(timeout: 5), "First car cell should appear in the list")
        
        firstCarCell.tap()

        let carDetailView = app.otherElements["CarDetailView"]
        XCTAssertTrue(carDetailView.waitForExistence(timeout: 5), "Car detail view should be displayed")
        
        let backButton = app.navigationBars.buttons.firstMatch
        XCTAssertTrue(backButton.exists, "Back button should exist")
        backButton.tap()

//        let carsListView = app.collectionViews["CarsListView"]
//        XCTAssertTrue(carsListView.waitForExistence(timeout: 5), "Should be back on the cars list")
    }
}
