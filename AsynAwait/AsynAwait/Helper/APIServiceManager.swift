//
//  APIServiceManager.swift
//  AsynAwait
//
//  Created by Macbook on 30/12/22.
//

import Foundation

enum HttpMethod: String {
    case POST = "POST"
    case GET = "GET"
}

struct APIProvider {
    static let baseUrl = "https://jsonplaceholder.typicode.com"
    static let apiGetPosts = "/posts"
}

protocol APIHandlerProtocol: AnyObject {
    func fetch<T: Codable>(requestUrl: String, requestMethod: HttpMethod, requestType: T.Type) async throws -> T
}


final class APIServiceManager: APIHandlerProtocol {
    
    func fetch<T: Codable>(requestUrl: String,
                           requestMethod: HttpMethod,
                           requestType: T.Type) async throws -> T {
        guard let url = URL(string: APIProvider.baseUrl + requestUrl) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = requestMethod.rawValue
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(T.self, from: data)
            
        } catch {
            throw URLError(.badServerResponse)
        }
    }
}
