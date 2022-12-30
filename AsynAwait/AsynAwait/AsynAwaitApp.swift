//
//  AsynAwaitApp.swift
//  AsynAwait
//
//  Created by Macbook on 30/12/22.
//

import SwiftUI

@main
struct AsynAwaitApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(vm: ViewModel(apiManager: APIServiceManager()))
        }
    }
}
