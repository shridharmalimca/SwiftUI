//
//  PostModel.swift
//  AsynAwait
//
//  Created by Macbook on 30/12/22.
//

struct Posts: Identifiable, Codable {
    let userID, id: Int
        let title, body: String

        enum CodingKeys: String, CodingKey {
            case userID = "userId"
            case id, title, body
        }
}
