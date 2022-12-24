//
//  ContentView.swift
//  CombineFrameworkNetworkingSwiftUI
//
//  Created by Macbook on 24/12/22.
//

import SwiftUI
import Combine
enum RequestError: Error {
    case invalidUrl
    case invalidRequest
    case invalidResponse
}

enum HttpMethod: String {
    case POST = "POST"
    case GET = "GET"
}

struct APIProvider {
    static let baseUrl = ""
    static let getPosts = ""
}

protocol APIHandlerProtocol: AnyObject {
    func fetch<T: Decodable>(requestUrl: String, requestMethod: HttpMethod, requestType: T.Type, completion: AnyPublisher<T, RequestError>)
}

final class APIHandlerService: APIHandlerProtocol {
    func fetch<T: Decodable>(requestUrl: String, requestMethod: HttpMethod, requestType: T.Type, completion: AnyPublisher<T, RequestError>) {
        guard let url = URL(string: requestUrl) else { return }
        /*let task: AnyCancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder)
            .replaceNil(with: T)*/
        
            
            
    }
    
    
}


struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
