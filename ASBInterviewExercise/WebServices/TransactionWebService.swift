//
//  WebService.swift
//  ASBInterviewExercise
//
//  Created by Kevin Mini M4 on 08/12/2024.
//
import Foundation

class TransactionWebService {
    
    private let baseURL: String
    private let restClient: RestClient
    private var activeTask: URLSessionTask?
    
    init(baseURL: String, restClient: RestClient) {
        self.baseURL = baseURL
        self.restClient = restClient
    }
    
    func fetchTransactionData(completion: @escaping (Data?) -> ()) {
        let endpoint = "\(baseURL)/test-data.json"
        guard let url = URL(string: endpoint) else {
            print("Invalid URL: \(endpoint)")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Retain the active task
        activeTask = restClient.apiRequest(request) { [weak self] data, response, error in
            defer { self?.activeTask = nil } // Clean up the task when this closure ends
            
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            // Return raw JSON data
            completion(data)
        }
    }
    
    /// Cancels the currently active network task
    func cancelActiveTask() {
        activeTask?.cancel()
        activeTask = nil
    }
}
