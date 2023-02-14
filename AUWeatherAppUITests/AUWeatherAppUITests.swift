//
//  AUWeatherAppUITests.swift
//  AUWeatherAppUITests
//
//  Created by Anand Upadhyay on 09/02/23.
//

import XCTest
@testable import AUWeatherApp

class AUWeatherAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

class WeatherAppUITest: XCTestCase{
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false;
        app.activate()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app.terminate()
    }
    
    func testUserLocationButtonTap(){
        app.buttons["MyCurrentLocation"].tap()
    }
    
    
    
    func testSearchLocationExist(){
//        app.maps.accessibilityele
//        let table = app.tables.element
          app.textFields["TextLocation"].tap()
//        XCTAssertTrue(!exists,"Text Field Exist")
    }
    
    
    func testUserSearchLocationWithCorrectInput()
    {
        let txtSearchLocation = app.textFields["TextLocation"]
        txtSearchLocation.tap()
        txtSearchLocation.typeText("Sydney")
        app.keyboards.buttons["Search"].tap()
    }
    
    func testUserSearchLocationWithInCorrectInput()
    {
        let txtSearchLocation = app.textFields["TextLocation"]
        txtSearchLocation.tap()
        txtSearchLocation.typeText("Hello John")
        app.keyboards.buttons["Search"].tap()
    }
    
    func testEmptySearchLocation(){
        let usernameTextField = app.textFields["TextLocation"]
        XCTAssert(usernameTextField.exists)
        usernameTextField.tap()
        app.keyboards.buttons["Search"].tap()
        app.alerts.firstMatch.buttons["Okay"].tap()
    }
    
    func testTableExist() throws {
        let table = app.tables.element
        XCTAssertTrue(table.exists)
    }
    
    func testOrienation(){
        (XCUIDevice.shared.orientation = .landscapeLeft)
    }
}

class CityListUITest: XCTestCase{
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false;
        app.activate()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app.terminate()
    }
    
    func testOpenCityList(){
        app.buttons["CityButton"].tap()
    }
    
    func testCityListTableExistance(){
        app.buttons["CityButton"].tap()
        let table = app.tables["CityListTable"]
        XCTAssert(table.waitForExistence(timeout: 2))
    }

    func testCityListTableLoaded(){
        app.buttons["CityButton"].tap()
        let table = app.tables["CityListTable"]
        XCTAssert(table.waitForExistence(timeout: 2))
        
        let complaintCell = table.cells.element(boundBy: 0)
        XCTAssert(complaintCell.waitForExistence(timeout: 30))
        
        table.cells.firstMatch.tap()
    }
}

class HistoryTest: XCTestCase{
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false;
        app.activate()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app.terminate()
    }
    
    func testHistoryTap(){
        let rightNavBarButton = XCUIApplication().navigationBars.buttons["HistoryButton"]
        XCTAssert(rightNavBarButton.exists)
        rightNavBarButton.tap()
    }
    
    func testSelectHistory(){
        let rightNavBarButton = XCUIApplication().navigationBars.buttons["HistoryButton"]
        XCTAssert(rightNavBarButton.exists)
        rightNavBarButton.tap()
        let isMenuAvailable = app.descendants(matching: .any).element(matching: .any, identifier: "HistoryMenu1").exists
        if isMenuAvailable
        {
            app.descendants(matching: .any).element(matching: .any, identifier: "HistoryMenu1").tap()
        }
    }
}


