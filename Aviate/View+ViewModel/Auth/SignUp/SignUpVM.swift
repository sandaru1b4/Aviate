//
//  SignUpVM.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import Foundation
import FirebaseAuth

class SignUpVM: BaseVM {
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isShowPassword = false
}


extension SignUpVM {
    
    func signUpCheck() throws {
        
        guard !email.isEmpty else {
            alertTitle = "Email Required"
            throw AppError.message("Please enter email")
        }
        
        guard Validator.emailValidator(value: email).isSuccess else {
            alertTitle = "Valid Email Required"
            throw AppError.message("Please enter a valid email address")
        }
        
        guard !password.isEmpty else {
            alertTitle = "Password Required"
            throw AppError.message("Please enter Password")
        }
        
        guard Validator.passwordValidator(value: password).isSuccess else {
            alertTitle = "Valid Password Required"
            throw AppError.message("Password should contain minimum of 8 characters")
        }
    }
    
    @MainActor
    func signUp() async throws {
        do {
            try checkInternetConnection()
            try signUpCheck()
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let user = result.user
            let userModel = User(_id: nil, uuid: user.uid, firstName: nil, lastName: nil, fullName: nil, email: user.email, accessToken: nil)
            AppManager.shared.signUp(userModel)
        } catch {
            throw error
        }
    }
    
}
