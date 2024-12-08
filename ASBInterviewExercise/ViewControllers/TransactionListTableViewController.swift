//
//  TransactionListTableViewController.swift
//  ASBInterviewExercise
//
//  Created by Kevin Mini M4 on 08/12/2024.
//
import Foundation
import UIKit

class TransactionListTableViewController: UITableViewController {
    
    
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
        
    }
}
