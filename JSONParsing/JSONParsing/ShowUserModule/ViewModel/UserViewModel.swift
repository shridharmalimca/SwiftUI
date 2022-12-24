//
//  UserViewModel.swift
//  JSONParsing
//
//  Created by Macbook on 24/12/22.
//
import SwiftUI

final class UserViewModel: ObservableObject {
    
    @Published var users: [User] = []
    private var apiHandler: APIHandler
    
    init(apiHandler: APIHandler) {
        self.apiHandler = apiHandler
    }
    
    func getUsers() {
        apiHandler.fetch(url: APIProvider.getUser,
                         requestMehtod: .GET,
                         requestType: [User].self) { [weak self] result in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let result):
                print(result)
                DispatchQueue.main.async {
                    weakSelf.users = result
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
