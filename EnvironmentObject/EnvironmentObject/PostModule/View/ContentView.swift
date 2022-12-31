//
//  ContentView.swift
//  EnvironmentObject
//
//  Created by Macbook on 31/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var vm = ViewModelFactory.shared.createViewModel()
    var body: some View {
        NavigationStack {
            List(vm.posts) { post in
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(post.id)")
                        Text(post.title)
                    }
                    Spacer()
                    NavigationLink("", destination: PostDetailsView()).frame(width: 40, height: 40)
                }
            }
            .onAppear {
                Task {
                    await vm.getPosts()
                }
            }
            .navigationTitle("Posts")
        }
        .environmentObject(vm)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
