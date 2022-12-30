//
//  ViewModel.swift
//  AsynAwait
//
//  Created by Macbook on 30/12/22.
//

import SwiftUI

@MainActor
final class ViewModel: ObservableObject {
    
    @Published var posts: [Posts] = []
    let apiManager: APIServiceManager
    
    init(apiManager: APIServiceManager) {
        self.apiManager = apiManager
    }
    
    func getPosts() async {
        do {
            self.posts = try await self.apiManager.fetch(requestUrl: APIProvider.apiGetPosts,
                                                       requestMethod: .GET,
                                                       requestType: [Posts].self)
            print(self.posts)
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
