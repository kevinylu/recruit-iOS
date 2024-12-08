//
//  TransactionViewModel.swift
//  ASBInterviewExercise
//
//  Created by Kevin Mini M4 on 08/12/2024.
//
import Foundation
import UIKit

// MARK: - Sort Order Enum
enum SortOrder {
    case ascending
    case descending
}

// MARK: - TransactionListViewModel
struct TransactionListViewModel {
    private var sortedTransactions: [Transaction]

    init(jsonData: Data, sortOrder: SortOrder = .descending) {
        do {
            let decoder = DecoderConfiguration.createDecoder()
            let transactions = try decoder.decode([Transaction].self, from: jsonData)
            self.sortedTransactions = Self.sortTransactions(transactions: transactions, by: sortOrder)
            
            // Check for UITestMode and load mock data if needed
            if CommandLine.arguments.contains("-UITestMode") {
                self.sortedTransactions = MockTransactionData.getTransactions()
            }
        } catch {
            print("Failed to decode transactions: \(error)")
            self.sortedTransactions = []
        }
    }

    var numberOfSections: Int {
        return 1
    }

    func numberOfRowsInSection(_ section: Int) -> Int {
        return sortedTransactions.count
    }

    func transactionAtIndex(_ index: Int) -> TransactionViewModel {
        let transaction = sortedTransactions[index]
        return TransactionViewModel(transaction)
    }

    static func sortTransactions(transactions: [Transaction], by order: SortOrder) -> [Transaction] {
        return transactions.sorted {
            order == .ascending ? $0.transactionDate < $1.transactionDate : $0.transactionDate > $1.transactionDate
        }
    }
}

// MARK: - TransactionViewModel
struct TransactionViewModel {
    public let gstRate = 0.15
    private let transaction: Transaction

    init(_ transaction: Transaction) {
        self.transaction = transaction
    }

    // Summary of the transaction
    var summary: String {
        return transaction.summary ?? "No Summary"
    }

    // Date formatted for list display
    var formattedTransactionDateForList: String {
        formatDate(transaction.transactionDate, using: "EEE dd MMM yyyy")
    }

    // Date formatted for detailed display
    var formattedTransactionDateForDetails: String {
        formatDate(transaction.transactionDate, using: "a hh:mm:ss EEE dd MMM yyyy")
    }

    // Amount (credit or debit) with appropriate label
    var formattedAmount: String {
        if transaction.credit > 0 {
            return String(format: "+ $%.2f", transaction.credit)
        } else if transaction.debit > 0 {
            return String(format: "- $%.2f", transaction.debit)
        } else {
            return "$0.00"
        }
    }

    // GST calculated based on credit or debit
    var gstAmount: String {
        let amount = transaction.credit > 0 ? transaction.credit : transaction.debit
        let gst = amount * gstRate
        return String(format: "$%.2f", gst)
    }

    // Color coding for the amount
    var amountColor: UIColor {
        if transaction.credit > 0 {
            return .green
        } else if transaction.debit > 0 {
            return .red
        } else {
            return .black
        }
    }

    // Helper to format the transaction date
    private func formatDate(_ date: Date, using format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_NZ")
        return formatter.string(from: date).uppercased()
    }
}

