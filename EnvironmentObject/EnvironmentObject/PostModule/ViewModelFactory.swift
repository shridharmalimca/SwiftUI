//
//  ViewModelFactory.swift
//  EnvironmentObject
//
//  Created by Macbook on 31/12/22.
//

final class ViewModelFactory {
    static let shared = ViewModelFactory()
    
    @MainActor func createViewModel() -> ViewModel {
        return ViewModel(apiHandler: APIManager())
    }
}
