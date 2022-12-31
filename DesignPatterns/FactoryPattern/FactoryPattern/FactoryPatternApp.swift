//
//  FactoryPatternApp.swift
//  FactoryPattern
//
//  Created by Macbook on 31/12/22.
//

import SwiftUI

@main
struct FactoryPatternApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(vm: ViewModel(apiHandler: APIManager()))
        }
    }
}
