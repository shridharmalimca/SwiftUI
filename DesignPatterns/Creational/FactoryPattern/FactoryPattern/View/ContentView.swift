//
//  ContentView.swift
//  FactoryPattern
//
//  Created by Macbook on 31/12/22.
//

import SwiftUI

final class ViewModelFactory {
    
    static let shared = ViewModelFactory()
    
    func makeViewModel() -> ViewModel {
        return ViewModel(apiHandler: APIManager())
    }
}

protocol APIHandlerProtocol: AnyObject {
    func fetch()
}

final class APIManager: APIHandlerProtocol {
    func fetch() {
        print("fetch called")
    }
}

final class ViewModel: ObservableObject {
    
    private let apiHandler: APIHandlerProtocol
    
    init(apiHandler: APIHandlerProtocol) {
        self.apiHandler = apiHandler
    }
    
    func getPost() {
        self.apiHandler.fetch()
    }
}

struct ContentView: View {
    
    @ObservedObject var vm = ViewModelFactory.shared.makeViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .onAppear {
            vm.getPost()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: ViewModel(apiHandler: APIManager()))
    }
}
