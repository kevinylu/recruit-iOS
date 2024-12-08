//
//  TransactionCellView.swift
//  ASBInterviewExercise
//
//  Created by Kevin Mini M4 on 08/12/2024.
//
import SwiftUI

struct TransactionCellView: View {
    let transactionViewModel: TransactionViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header Section
            Text(transactionViewModel.formattedTransactionDateForList)
                .font(.subheadline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.lightGray))
                .accessibilityIdentifier("TransactionDate")

            // Body Section
            TransactionBodyView(transactionViewModel: transactionViewModel, showArrowRight: true)
        }
        .padding() // Padding for the entire cell
    }
}
