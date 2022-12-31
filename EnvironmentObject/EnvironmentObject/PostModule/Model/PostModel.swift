//
//  PostModel.swift
//  EnvironmentObject
//
//  Created by Macbook on 31/12/22.
//

struct Post: Codable, Identifiable {
    
    let userID, id: Int
    let title, body: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
