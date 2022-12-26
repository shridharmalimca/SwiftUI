//
//  ContentView.swift
//  NavigationItem
//
//  Created by Macbook on 26/12/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
            .padding()
            .navigationTitle("Welcome")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("First") {
                        print("First clicked")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Second") {
                        print("Second click")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
