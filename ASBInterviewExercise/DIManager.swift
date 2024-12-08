//
//  DIManager.swift
//  ASBInterviewExercise
//
//  Created by ASB on 29/07/21.
//

import Foundation
import Swinject

class DIManager {
    static let shared = DIManager()
    
    var assembler: Assembler
    
    init() {
        let assembler = Assembler([ServiceAssembly()])
        self.assembler = assembler
    }
    
    func resolve<T>(_ type: T.Type) -> T? {
        return assembler.resolver.resolve(type)
    }
}

class ServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(RestClient.self) { resolver in
            return RestClient()
        }.inObjectScope(.transient)
        
        // Register the base URL
        container.register(String.self, name: "BaseURL") { _ in
            "https://gist.githubusercontent.com/Josh-Ng/500f2716604dc1e8e2a3c6d31ad01830/raw/4d73acaa7caa1167676445c922835554c5572e82"
        }
        
        // Register Webservice with dependencies injected
        container.register(TransactionWebService.self) { resolver in
            let baseURL = resolver.resolve(String.self, name: "BaseURL")!
            let restClient = resolver.resolve(RestClient.self)!
            return TransactionWebService(baseURL: baseURL, restClient: restClient)
        }.inObjectScope(.transient)
    }
}
