//
//  APIHandler.swift
//  JSONParsing
//
//  Created by Macbook on 24/12/22.
//

import SwiftUI

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
    static let baseUrl = "https://api.github.com" //"https://jsonplaceholder.typicode.com"
    static let getUser = "/users"
    static let getPosts = "/posts"
}

protocol APIServiceProtocol: AnyObject {
    func fetch<T: Decodable>(url: String,
                           requestMehtod: HttpMethod,
                           requestType: T.Type,
                           completion: @escaping (Result<T, RequestError>) -> Void)
}

final class APIHandler: APIServiceProtocol {
    
    func fetch<T: Decodable>(url: String,
                           requestMehtod: HttpMethod,
                           requestType: T.Type,
                           completion: @escaping (Result<T, RequestError>) -> Void) {
        
        guard let url = URL(string: APIProvider.baseUrl + url) else {
            completion(.failure(.invalidUrl))
            return
        }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = requestMehtod.rawValue
        URLSession.shared.dataTask(with: request) { responseData, urlResponse, error in
            guard let data = responseData else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                // jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try jsonDecoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                print(error.localizedDescription)
                completion(.failure(.invalidResponse))
            }
        }.resume()
    }
}
