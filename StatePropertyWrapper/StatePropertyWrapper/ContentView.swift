//
//  ContentView.swift
//  StatePropertyWrapper
//
//  Created by Macbook on 22/12/22.
//

import SwiftUI

struct ContentView: View {
    @State private var isEditable: Bool = false
    @State private var name: String = "Initial Value"
    var body: some View {
        VStack {
            Spacer()
            Text(name)
            Spacer()
            Button("Change Name") {
                name = "Shridhar"
            }
            .font(.title)
            .foregroundColor(.black)
            .background(Color.orange)
            .cornerRadius(10)
            .padding()
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
