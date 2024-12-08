//
//  TransactionTableViewCell.swift
//  ASBInterviewExercise
//
//  Created by Kevin Mini M4 on 08/12/2024.
//
import SwiftUI
import UIKit

class TransactionTableViewCell: UITableViewCell {
    private var hostingController: UIHostingController<TransactionCellView>?

    func configure(with transactionViewModel: TransactionViewModel) {
        let cellView = TransactionCellView(transactionViewModel: transactionViewModel)
        
        if hostingController == nil {
            hostingController = UIHostingController(rootView: cellView)
            guard let hostingController = hostingController else { return }
            
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(hostingController.view)
            
            // Add constraints to fit the SwiftUI view within the cell
            NSLayoutConstraint.activate([
                hostingController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                hostingController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ])
        } else {
            hostingController?.rootView = cellView
        }
    }
}
