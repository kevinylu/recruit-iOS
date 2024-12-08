//
//  Transaction.swift
//  ASBInterviewExercise
//
//  Created by Kevin Mini M4 on 08/12/2024.
//
import Foundation

struct Transaction: Decodable {
    let id: Int
    let transactionDate: Date
    let summary: String?
    let debit: Double
    let credit: Double
}
