//
//  ContentView.swift
//  CoreDataCRUD
//
//  Created by Macbook on 24/12/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = CoreDataViewModel()
    @State var name: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                TextField("Add fruits here..", text: $name)
                    .padding(.leading)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button {
                    guard !name.isEmpty else { return }
                    vm.addFruits(name: name)
                    name = ""
                } label: {
                    Text("Button")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.pink)
                        .cornerRadius(10)
                        .padding(.horizontal)

                }
                List {
                    ForEach(vm.savedFruits) { entity in
                        VStack {
                            Text(entity.name ?? "NO NAME")
                                .onTapGesture {
                                    vm.update(entity)
                                }
                        }
                    }
                    .onDelete(perform: vm.deleteFruit)
                }.listStyle(PlainListStyle())
            }
            .navigationTitle("Fruits")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
