//
//  ContentView.swift
//  AsynAwait
//
//  Created by Macbook on 30/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var vm: ViewModel = ViewModel(apiManager: APIServiceManager())
    
    var body: some View {
        NavigationStack {
            List(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text("\(post.id)")
                        .font(.title2)
                    Text(post.title)
                        .font(.subheadline)
                }
            }.onAppear {
                Task {
                    await vm.getPosts()
                }
            }
            .navigationTitle("Posts")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let viewModel = ViewModel(apiManager: APIServiceManager())
    static var previews: some View {
        ContentView(vm: viewModel)
    }
}
