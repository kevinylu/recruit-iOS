//
//  TransactionDetailsViewController.swift
//  ASBInterviewExercise
//
//  Created by Kevin Mini M4 on 08/12/2024.
//

import SwiftUI
import UIKit

class TransactionDetailsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCustomDisplay()
    }
    
    private func setUpCustomDisplay() {
        
        // Set the title for the current view controller
        navigationItem.title = "Details"
    }
    
}
