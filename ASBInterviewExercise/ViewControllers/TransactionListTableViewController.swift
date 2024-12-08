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
        self.view.accessibilityIdentifier = navigationItem.title
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.transactionListViewModel == nil ? 0 : self.transactionListViewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactionListViewModel.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath) as? TransactionTableViewCell else {
            fatalError("TransactionTableViewCell not found")
        }
        
        let transactionViewModel = self.transactionListViewModel.transactionAtIndex(indexPath.row)
        cell.configure(with: transactionViewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the selected transaction view model
        let selectedViewModel = transactionListViewModel.transactionAtIndex(indexPath.row)
        
        // Create the TransactionDetailsViewController with the selected view model
        let detailsViewController = TransactionDetailsViewController(transactionViewModel: selectedViewModel)
        
        // Push it onto the navigation stack
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
