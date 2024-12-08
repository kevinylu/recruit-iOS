//
//  ASBInterviewExerciseUITests.swift
//  ASBInterviewExerciseUITests
//
//  Created by ASB on 29/07/21.
//

import XCTest

class ASBInterviewExerciseUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // Launch the app with mock data for testing
        app.launchArguments += ["-UITestMode"]
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLongSummaryText() throws {
        // Define a long summary for testing
        let longSummary = String(repeating: "This is a very long summary. ", count: 10)
        
        // Validate the summary is truncated in the list view
        let transactionSummary = app.staticTexts["TransactionSummary"]
        XCTAssertTrue(transactionSummary.exists, "Transaction summary should be visible in the cell.")
        
        // Navigate to the details view
        let firstCell = app.cells.firstMatch
        XCTAssertTrue(firstCell.exists, "A transaction cell should exist.")
        firstCell.tap()
        
        // Validate the full summary is displayed in the details view
        let detailSummary = app.staticTexts["DetailSummary"]
        XCTAssertEqual(detailSummary.label, longSummary, "Full summary should be displayed in the details view.")
    }
}
