//
//  Validator.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import Foundation

enum Validator {
    
    static func emailValidator(value: String, value2: String? = nil) -> ValidationStatus {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        guard emailPredicate.evaluate(with: value) else {
            return .failure(message: .Warning.invalidEmail)
        }
        return .success
    }
    
    static func passwordValidator(value: String, value2: String? = nil) -> ValidationStatus {
        if (value.count >= 8) {
            return .success
        }
        return .failure(message: .Warning.shortPassword)
    }
    
}

enum ValidationStatus {
    case standard
    case success
    case failure(message: String)
    
    var isSuccess: Bool {
        if case .success = self {
            return true
        }
        return false
    }
}
