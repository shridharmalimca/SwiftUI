//
//  ContentView.swift
//  AlertView
//
//  Created by Macbook on 26/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShowAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
                Spacer()
                Button("Alert with two button") {
                    isShowAlert = true
                }
                .alert(isPresented: $isShowAlert) {
                    Alert(title: Text("Title"),
                          message: Text("Message"),
                          primaryButton: .default(Text("Ok"), action: {
                        print("Ok Clicked")
                    }),
                          secondaryButton: .cancel(Text("Cancel"), action: {
                        print("Cancel clicked")
                    }))
                }
                
                Spacer()
                
            }
            .padding()
            .navigationTitle("AlertView")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
