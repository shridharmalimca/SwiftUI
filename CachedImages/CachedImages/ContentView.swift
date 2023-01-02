//
//  ContentView.swift
//  CachedImages
//
//  Created by Macbook on 01/01/23.
//

import SwiftUI

struct APIProvider {
    static let baseUrl = "https://jsonplaceholder.typicode.com"
    static let getPhotos = "/photos"
}

enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
}

protocol APIHandlerProtocol: AnyObject {
    func fetch<T: Codable>(requestUrl: String,
                           requestMethod: HttpMethod,
                           requestType: T.Type) async throws -> T
}

final class APIManager: APIHandlerProtocol {
    
    func fetch<T: Codable>(requestUrl: String, requestMethod: HttpMethod, requestType: T.Type) async throws -> T {
    
        guard let url = URL(string: APIProvider.baseUrl + requestUrl) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = requestMethod.rawValue
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}

final class ViewModelFactory {
    static let shared = ViewModelFactory()
    
    @MainActor func createViewModel() -> ViewModel {
        return ViewModel(apiHandler: APIManager())
    }
}

struct Photos: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

@MainActor
final class ViewModel: ObservableObject {
    @Published var photos: [Photos] = []
    
    private let apiHandler: APIHandlerProtocol
    
    init(apiHandler: APIHandlerProtocol) {
        self.apiHandler = apiHandler
    }
    
    func getPhotos() async throws {
        self.photos = try await self.apiHandler.fetch(requestUrl: APIProvider.getPhotos,
                              requestMethod: .get, requestType: [Photos].self)
        print(self.photos.count)
        for item in self.photos {
            do {
                try await saveImageInCache(urlString: item.thumbnailUrl)
            } catch {
                print("\(item.title) : \(item.thumbnailUrl) not downloaded")
            }
        }
    }
    
    func saveImageInCache(urlString: String) async throws {
        guard let url = URL(string: urlString) else { return }
        print("Downloding: \(url)")
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else { throw URLError(.badServerResponse)}
        print("Set in cache: \(urlString)")
        ImageCache.getImageCache().set(forKey: urlString, image: image)
    }
    
    func getImageFromCache(url: String?) -> UIImage? {
        guard let imageUrl = url else {
            return nil
        }
        print("get in cache: \(imageUrl)")
        return ImageCache.getImageCache().get(forkey: imageUrl)
    }
    
 }

final class ImageCache {
    
    var cache = NSCache<NSString, UIImage>()
    static var imageCache = ImageCache()
    
    static func getImageCache() -> ImageCache {
        return imageCache
    }
     
    func get(forkey: String) -> UIImage? {
        return cache.object(forKey: forkey as NSString)
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: forKey as NSString)
    }
}


struct ContentView: View {
    
    @ObservedObject var vm: ViewModel = ViewModelFactory.shared.createViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                List(vm.photos) { photo in
                    HStack {
                        if let image = vm.getImageFromCache(url: photo.thumbnailUrl) {
                            Image(uiImage: image)
                        } else {
                            AsyncImage(url: URL(string: photo.thumbnailUrl )) { image in
                                image
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        Text(photo.title)
                    }
                }
                .onAppear {
                    Task {
                        do {
                            try await vm.getPhotos()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            .navigationTitle("Photos")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
