//
//  ContentView.swift
//  Form
//
//  Created by Macbook on 30/12/22.
//

import SwiftUI
import Combine

final class TextValidator: ObservableObject {
    @Published var text: String = ""
}

struct ContentView: View {
    
    @State private var isProfileActive: Bool = false
    @State private var age: Int = 0
    
    @ObservedObject var vm: FormViewModel = FormViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section("User Information") {
                    HStack {
                        Text("Name")
                        TextField("Enter username", text: $vm.userName)
                    }
                    HStack {
                        Text("Email")
                        TextField("Enter email", text: $vm.email)
                            .keyboardType(.emailAddress)
                    }
                }
                Section("") {
                    Button {
                        
                    } label: {
                        Text("Submit")
                    }
                    .disabled(!vm.isFormValid)
                }
                
                Section("Other Info") {
                    Toggle("Activate Profile", isOn: $isProfileActive)
                    Stepper("Age", value: $age, in: 1...70)
                    Text("Selected age: \(age)")
                }
            }
            .navigationTitle("Form")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
