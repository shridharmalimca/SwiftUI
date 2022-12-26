//
//  ContentView.swift
//  NavigationList
//
//  Created by Macbook on 16/12/22.
//

import SwiftUI

struct ContentView: View {
    @State var arrayOfItem: [String] = ["first", "second", "third"]
    var body: some View {
        
        NavigationStack {
            List(arrayOfItem, id: \.self) { item in
                
                HStack {
                    Image(systemName: "globe")
                    VStack(alignment: .leading) {
                        Text(item)
                            .font(.title2)
                        
                        Text("SubTitle")
                            .font(.subheadline)
                        
                    }
                    
                    NavigationLink(destination: DetailsView()) {
                        
                    }
                }
            }
            .navigationTitle("Navigation List")
        }
    }
}

struct DetailsView: View {
    var body: some View {
        Text("Details view")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
