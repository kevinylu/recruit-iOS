//
//  ASBInterviewExerciseTests.swift
//  ASBInterviewExerciseTests
//
//  Created by ASB on 29/07/21.
//
import XCTest
@testable import ASBInterviewExercise

class ASBInterviewExerciseTests: XCTestCase {
    
    var transaction: Transaction!
    var viewModel: TransactionViewModel!
    
    override func setUpWithError() throws {
        // Initialize a sample Transaction object before each test
        let date = Date(timeIntervalSince1970: 1700000000)
        transaction = Transaction(
            id: 1,
            transactionDate: date, // Example date
            summary: "Test Transaction",
            debit: 100.0,
            credit: 0.0
        )
        viewModel = TransactionViewModel(transaction)
    }
    
    override func tearDownWithError() throws {
        // Clean up after each test
        transaction = nil
        viewModel = nil
    }
    
    // Test the summary field
    func testSummary() {
        XCTAssertEqual(viewModel.summary, "Test Transaction", "Summary should match the input value.")
    }
    
    // Test formattedTransactionDateForList
    func testFormattedTransactionDateForList() {
        let formattedDate = viewModel.formattedTransactionDateForList
        XCTAssertEqual(formattedDate, "WED 15 NOV 2023", "The formatted list date is incorrect.")
    }
    
    // Test formattedTransactionDateForDetails
    func testFormattedTransactionDateForDetails() {
        let formattedDate = viewModel.formattedTransactionDateForDetails
        XCTAssertEqual(formattedDate, "AM 11:13:20 WED 15 NOV 2023", "The formatted details date is incorrect.")
    }
    
    // Test formattedAmount for debit
    func testFormattedAmountDebit() {
        XCTAssertEqual(viewModel.formattedAmount, "- $100.00", "Formatted amount for debit is incorrect.")
    }
    
    // Test formattedAmount for credit
    func testFormattedAmountCredit() {
        transaction = Transaction(
            id: 2,
            transactionDate: Date(),
            summary: "Credit Transaction",
            debit: 0.0,
            credit: 200.0
        )
        viewModel = TransactionViewModel(transaction)
        XCTAssertEqual(viewModel.formattedAmount, "+ $200.00", "Formatted amount for credit is incorrect.")
    }
    
    // Test GST calculation
    func testGSTAmount() {
        let expectedGST = viewModel.gstRate * 100.0 // Debit is $100.0 in setup
        let expectedGSTString = String(format: "$%.2f", expectedGST)
        
        XCTAssertEqual(viewModel.gstAmount, expectedGSTString, "GST calculation is incorrect.")
    }
    
    // Test amountColor for debit
    func testAmountColorDebit() {
        XCTAssertEqual(viewModel.amountColor, UIColor.red, "Amount color for debit is incorrect.")
    }
    
    // Test amountColor for credit
    func testAmountColorCredit() {
        transaction = Transaction(
            id: 3,
            transactionDate: Date(),
            summary: "Credit Transaction",
            debit: 0.0,
            credit: 150.0
        )
        viewModel = TransactionViewModel(transaction)
        XCTAssertEqual(viewModel.amountColor, UIColor.green, "Amount color for credit is incorrect.")
    }
    
    // Test fallback for missing summary
    func testSummaryFallback() {
        transaction = Transaction(
            id: 4,
            transactionDate: Date(),
            summary: nil,
            debit: 50.0,
            credit: 0.0
        )
        viewModel = TransactionViewModel(transaction)
        XCTAssertEqual(viewModel.summary, "No Summary", "Fallback summary for nil value is incorrect.")
    }
    
}

