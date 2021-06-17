//
//  CoinHako_ViperUITests.swift
//  CoinHako_ViperUITests
//
//  Created by Tien Dat on 6/14/21.
//

import XCTest

class CoinHako_ViperUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchBar() throws {
        let app = XCUIApplication()
        app.launch()
        // Wait for UI to update
        sleep(3)
        let searchTextField = app.textFields["searchTextField"]
        let listView = app.tables

        let notFilteredCount = listView.cells.count
        searchTextField.tap()
        searchTextField.typeText("B")
        searchTextField.typeText("T")
        searchTextField.typeText("C")
        // Wait for thorrtle to trigger crypto filtering
        sleep(1)
        XCTAssertNotEqual(notFilteredCount, listView.cells.count)
        let clearButton = searchTextField.buttons.firstMatch
        clearButton.tap()
        XCTAssertEqual(searchTextField.label, "")
        sleep(1)
        XCTAssertEqual(notFilteredCount, listView.cells.count)
    }
    
    func testPriceIsUpdate() {
        let app = XCUIApplication()
        app.launch()
        let searchTextField = app.textFields["searchTextField"]
        let listView = app.tables["cryptoList"]
        searchTextField.tap()
        searchTextField.typeText("B")
        searchTextField.typeText("T")
        searchTextField.typeText("C")
        sleep(1)
        let first = listView.cells["CryptoCell"].staticTexts["buyPrice"].label
        sleep(35)
        XCTAssertFalse(first == listView.cells["CryptoCell"].staticTexts["buyPrice"].label)
    }
}
