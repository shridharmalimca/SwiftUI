//
//  ContentView.swift
//  ConcurrencyUsingAsyncAwait
//
//  Created by Macbook on 28/12/22.
//

import SwiftUI
import Combine

@MainActor
final class EscapingImageDownloadViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    var cancellable = Set<AnyCancellable>()
    func fetchImage() async {
        // With escaping closure
//        self.downloadImage { result in
//            switch result {
//            case .success(let image):
//                guard let image = image else { return }
//                DispatchQueue.main.async {
//                    self.image = image
//                }
//                // self.image = image
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        
        // With Combine
//        self.downloadImageCombinePublisher()
//            .sink { completion in
//                print("FINISHED: \(completion)")
//            } receiveValue: { [weak self] image in
//                DispatchQueue.main.async {
//                    self?.image = image
//                }
//            }
//            .store(in: &cancellable)
        
        
        // with Async await
        let image = try? await self.downloadWithAsyncAwait()
        self.image = image
    }
    
    func downloadWithAsyncAwait() async throws -> UIImage? {
        
        guard let url = URL(string: "https://picsum.photos/200") else { return nil }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            return self.handleResponse(data: data, response: response)
            
        } catch {
            throw URLError(.badServerResponse)
        }
    }
    
    func downloadImageCombinePublisher() -> AnyPublisher<UIImage?, URLError> {
        let url = URL(string: "https://picsum.photos/200")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(handleResponse)
            .mapError({$0})
            .eraseToAnyPublisher()
    }
    
    func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard let data = data,
              let response = response as? HTTPURLResponse,
              response.statusCode == 200,
              let image = UIImage(data: data) else {
            return nil
        }
        
        return image
    }
    
    func downloadImage(completionHandler: @escaping (Result<UIImage?, URLError>) -> ()) {
        
        guard let url = URL(string: "https://picsum.photos/200") else {
            completionHandler(.failure(URLError(.badURL)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let result = UIImage(data: data) else {
                completionHandler(.failure(URLError(.badServerResponse)))
                return
            }
            completionHandler(.success(result))
        }.resume()
    }
}

struct ContentView: View {
    
    @StateObject var vm: EscapingImageDownloadViewModel = EscapingImageDownloadViewModel()
    
    var body: some View {
        VStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            }
            Text("Hello, world!")
        }
        .onAppear {
            Task {
                await vm.fetchImage()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
