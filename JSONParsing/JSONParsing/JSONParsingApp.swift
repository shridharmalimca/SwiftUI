//
//  JSONParsingApp.swift
//  JSONParsing
//
//  Created by Macbook on 22/12/22.
//

import SwiftUI

@main
struct JSONParsingApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: UserViewModel(apiHandler: APIHandler()))
        }
    }
}
