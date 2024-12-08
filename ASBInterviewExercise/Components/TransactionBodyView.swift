//
//  TransactionBodyView.swift
//  ASBInterviewExercise
//
//  Created by Kevin Mini M4 on 08/12/2024.
//
import SwiftUI

struct TransactionBodyView: View {
    let transactionViewModel: TransactionViewModel
    let showArrowRight: Bool // Determines if the chevron is displayed
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Text(transactionViewModel.summary)
                .font(.subheadline)
                .foregroundColor(.primary)
                .truncationMode(.tail)
                .lineLimit(2) // Allow up to 2 lines
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true) // Enable wrapping
                .accessibilityIdentifier("TransactionSummary")
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(transactionViewModel.formattedAmount)
                    .font(.subheadline)
                    .foregroundColor(Color(transactionViewModel.amountColor))
                    .accessibilityIdentifier("TransactionAmount")
                Text("GST: \(transactionViewModel.gstAmount)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .accessibilityIdentifier("TransactionGST")
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            if showArrowRight {
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 4) 
    }
}
