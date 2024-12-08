//
//  TransactionDetailsView.swift
//  ASBInterviewExercise
//
//  Created by Kevin Mini M4 on 08/12/2024.
//
import SwiftUI

struct TransactionDetailsView: View {
    let transactionViewModel: TransactionViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TransactionBodyView(transactionViewModel: transactionViewModel, showArrowRight: false)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Summary:").font(.headline)
                Text("\(transactionViewModel.summary)")
                    .font(.subheadline)
                    .accessibilityIdentifier("DetailSummary")
                Text("Date:").font(.headline)
                Text("\(transactionViewModel.formattedTransactionDateForDetails)")
                    .font(.subheadline)
                    .accessibilityIdentifier("DetailDate")
                Text("Amount:").font(.headline)
                Text("\(transactionViewModel.formattedAmount)")
                    .font(.subheadline)
                    .foregroundColor(Color(transactionViewModel.amountColor))
                    .accessibilityIdentifier("DetailAmount")
                Text("GST:").font(.headline)
                Text("\(transactionViewModel.gstAmount)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .accessibilityIdentifier("DetailGST")
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Details")
    }
}
