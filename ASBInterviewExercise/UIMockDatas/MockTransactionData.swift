//
//  MockTransactionData.swift
//  ASBInterviewExercise
//
//  Created by Kevin Mini M4 on 08/12/2024.
//
import Foundation

struct MockTransactionData {
    
    public static let textTepeating = "This is a very long summary. "
    
    private static var transactions: [Transaction] = []

    static func setTransactions(_ newTransactions: [Transaction]) {
        transactions = newTransactions
    }

    static func getTransactions() -> [Transaction] {
        let longSummary = String(repeating: textTepeating, count: 10)
        let date = Date(timeIntervalSince1970: 1700000000)
        
        if transactions.isEmpty {
            // Provide default mock data if none is set
            return [
                Transaction(
                    id: 1,
                    transactionDate: date,
                    summary: longSummary,
                    debit: 0.0,
                    credit: 100.0
                ),
                Transaction(
                    id: 2,
                    transactionDate: date,
                    summary: longSummary,
                    debit: 50.0,
                    credit: 0.0
                )
            ]
        }
        return transactions
    }
}
