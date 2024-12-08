//
//  TransactionListTableViewController.swift
//  ASBInterviewExercise
//
//  Created by Kevin Mini M4 on 08/12/2024.
//
import Foundation
import UIKit

class TransactionListTableViewController: UITableViewController {
    
    private var transactionListViewModel: TransactionListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCustomDisplay()
        setupWebService()
    }
    
    private func setUpCustomDisplay() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        
        navigationItem.title = "ASB Transactions"
    }
    
    private func setupWebService() {
        let webService: TransactionWebService = DIManager.shared.resolve(TransactionWebService.self)!
        
        webService.fetchTransactionData { [weak self] jsonData in
            guard let self = self else { return }
            
            if let jsonData = jsonData {
                self.transactionListViewModel = TransactionListViewModel(jsonData: jsonData)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("Failed to fetch transaction data.")
            }
        }
    }
}
