//
//  PostModel.swift
//  JSONParsing
//
//  Created by Macbook on 24/12/22.
//

struct Posts: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
