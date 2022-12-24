//
//  ContentView.swift
//  JSONParsing
//
//  Created by Macbook on 22/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: UserViewModel
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                List(searchResult, id: \.id) { item in
                    HStack {
                        if let url = item.avatarUrl {
                            AsyncImage(url: URL(string: url)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }.frame(width: 50, height: 50)
                                .clipShape(Circle())
                        }
                        Text(item.login)
                        Spacer()
                        NavigationLink {
                            
                        } label: {
                            
                        }
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search for user")
        .onAppear {
            viewModel.getUsers()
        }
    }
    
    var searchResult: [User] {
        if searchText.isEmpty {
            return viewModel.users
        } else {
            return viewModel.users.filter { $0.login.localizedCaseInsensitiveContains(searchText)}
        }
    }
}
/*
struct ContentView_Previews: PreviewProvider {
    weak var apiHandler: APIHandler?
    static var previews: some View {
        ContentView(viewModel: UserViewModel(apiHandler: apiHandler!))
    }
}*/
