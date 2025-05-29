//
//  LoginVM.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import Foundation
import FirebaseAuth

class LoginVM: BaseVM {
    
    //text inputs
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isShowPassword = false
    
}

extension LoginVM {
    
    func signInCheck() throws {
       
        guard !password.isEmpty else {
            alertTitle = "Password Required"
            throw AppError.message("Please enter Password")
        }
        
        guard Validator.passwordValidator(value: password).isSuccess else {
            alertTitle = "Valid Password Required"
            throw AppError.message("Password should contain minimum of 8 characters")
        }
        
        guard Validator.emailValidator(value: email).isSuccess else {
            alertTitle = "Valid Email Required"
            throw AppError.message("Please enter a valid email address")
        }
    }
 
    @MainActor
      func login() async throws {
          do {
              try checkInternetConnection()
              try signInCheck()
              let result = try await Auth.auth().signIn(withEmail: email, password: password)
              let user = result.user
              let userModel = User(_id: nil, uuid: user.uid, firstName: nil, lastName: nil, fullName: nil, email: user.email, accessToken: nil)
              AppManager.shared.signIn(userModel)
          } catch {
              throw error
          }
      }
    
}
