//
//  ViewModel.swift
//  EnvironmentObject
//
//  Created by Macbook on 31/12/22.
//

import Foundation

@MainActor
final class ViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    private let apiHandler: APIHandlerProtocol
    
    init(apiHandler: APIHandlerProtocol) {
        self.apiHandler = apiHandler
    }
    
    func getPosts() async {
        do {
            self.posts = try await self.apiHandler.fetch(requestUrl: APIProvider.getPosts,
                                                         requestMethod: .get, requestType: [Post].self)
        } catch {
            print(error.localizedDescription)
        }
    }
}
