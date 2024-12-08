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
    
    // Test if the transaction list displays correctly
    func testTransactionListDisplaysCorrectly() throws {
        // Check if the table exists
        let table = app.tables.firstMatch
        XCTAssertTrue(table.exists, "Transaction list table should exist.")
        
        // Wait for the transaction date to appear
        let transactionDate = table.staticTexts["TransactionDate"]
        let exists = transactionDate.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "Transaction date should be visible in the cell.")
    }
    
    // Test navigation from transaction cell to details view
    func testNavigateToTransactionDetails() throws {
        // Find and tap the first transaction cell
        let firstCell = app.cells.firstMatch
        XCTAssertTrue(firstCell.exists, "A transaction cell should exist.")
        firstCell.tap()
        
        // Validate navigation to the details view
        let detailsNavigationBar = app.navigationBars["Details"]
        XCTAssertTrue(detailsNavigationBar.exists, "Details view should be displayed with the correct title.")
        
        // Validate content in the details view
        let detailSummary = app.staticTexts["DetailSummary"]
        let detailDate = app.staticTexts["DetailDate"]
        let detailAmount = app.staticTexts["DetailAmount"]
        let detailGST = app.staticTexts["DetailGST"]
        
        XCTAssertTrue(detailSummary.exists, "Summary should be visible in the details view.")
        XCTAssertTrue(detailDate.exists, "Date should be visible in the details view.")
        XCTAssertTrue(detailAmount.exists, "Amount should be visible in the details view.")
        XCTAssertTrue(detailGST.exists, "GST should be visible in the details view.")
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
