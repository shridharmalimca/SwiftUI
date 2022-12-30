//
//  FormViewModel.swift
//  Form
//
//  Created by Macbook on 30/12/22.
//

import Combine
import Foundation

final class FormViewModel: ObservableObject {
    
    @Published var userName: String = ""
    @Published var email: String = ""
    @Published var isFormValid: Bool = false
    
    
    var publisher = Set<AnyCancellable>()
    
    init() {
        isFormValidPusblisher
            .receive(on: RunLoop.main)
            .assign(to: \.isFormValid, on: self)
            .store(in: &publisher)
    }
    
    var isUserNameValidPublisher: AnyPublisher<Bool, Never> {
        $userName
            .map { name in
                return name.count > 2
            }
            .eraseToAnyPublisher()
    }
    
    var isValidEmailPublisher: AnyPublisher<Bool, Never> {
        $email
            .map { email in
                let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
                return emailPredicate.evaluate(with: email)
            }
            .eraseToAnyPublisher()
    }
    
    var isFormValidPusblisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isUserNameValidPublisher, isValidEmailPublisher)
            .map { isUserNameValid, isValidEmail in
                return isUserNameValid && isValidEmail
            }
            .eraseToAnyPublisher()
    }
}
