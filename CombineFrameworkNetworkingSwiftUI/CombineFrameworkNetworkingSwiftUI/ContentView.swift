//
//  ContentView.swift
//  CombineFrameworkNetworkingSwiftUI
//
//  Created by Macbook on 24/12/22.
//

import SwiftUI
import Combine

struct Posts: Identifiable, Codable {
    let userID, id: Int
       let title, body: String

       enum CodingKeys: String, CodingKey {
           case userID = "userId"
           case id, title, body
       }
}

final class PostsViewModel: ObservableObject {
    @Published var posts: [Posts] = []
    var cancellable = Set<AnyCancellable>()
    init() {
        
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [Posts].self, decoder: JSONDecoder())
            .sink { completion in
                print("COMPLETION: \(completion)")
            } receiveValue: { [weak self] posts in
                self?.posts = posts
            }
            .store(in: &cancellable)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return output.data
    }
}


struct ContentView: View {
    @StateObject var vm: PostsViewModel = PostsViewModel()
    @State var serachtext: String = ""
    var body: some View {
        NavigationStack {
            List(searchResult) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.title)
                    Text(post.body)
                        .font(.subheadline)
                }
            }
            .onAppear {
                vm.getPosts()
            }
            .navigationTitle("Posts")
            .searchable(text: $serachtext)
        }
    }
    
    var searchResult: [Posts] {
        if serachtext.isEmpty {
            return vm.posts
        } else {
            return vm.posts.filter { $0.title.localizedCaseInsensitiveContains(serachtext)}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
