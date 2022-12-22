//
//  ContentView.swift
//  StateAndBinding
//
//  Created by Macbook on 22/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isEditable: Bool = false
    @State private var name: String = ""

    var body: some View {
        VStack {
            TextField("Enter name", text: $name)
            LabelView(name: $name)
            Text(name)
        }
        .padding()
    }
}

struct LabelView: View {
    @Binding var name: String
    
    var body: some View {
        VStack {
            Text(name)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
