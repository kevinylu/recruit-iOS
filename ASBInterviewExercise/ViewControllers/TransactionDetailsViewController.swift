//
//  TransactionDetailsViewController.swift
//  ASBInterviewExercise
//
//  Created by Kevin Mini M4 on 08/12/2024.
//

import SwiftUI
import UIKit

class TransactionDetailsViewController: UIViewController {
    
    private var transactionViewModel: TransactionViewModel!

    init(transactionViewModel: TransactionViewModel) {
        self.transactionViewModel = transactionViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCustomDisplay()
    }
    
    private func setUpCustomDisplay() {
        
        // Set the title for the current view controller
        navigationItem.title = "Details"
        self.view.accessibilityIdentifier = "Transaction Details"
        
        let detailsView = TransactionDetailsView(transactionViewModel: transactionViewModel)
        let hostingController = UIHostingController(rootView: detailsView)

        // Add hostingController as a child
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)

        // Setup constraints to fit the entire screen
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        hostingController.didMove(toParent: self)
    }
    
}
