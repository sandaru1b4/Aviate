//
//  String++.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import Foundation

extension String {
    enum Warning {
        static let invalidEmail = NSLocalizedString("Invalid email address.", comment: "")
        static let mismatchingPasswords = NSLocalizedString("The password you have entered do not match", comment: "")
        static let shortPassword = NSLocalizedString("Password should be at least 8 characters.", comment: "")
        static let noInternet = NSLocalizedString("Internet connection offline.", comment: "")
    }
    static let Error = NSLocalizedString("Error", comment: "")
    static let Incomplete = NSLocalizedString("Incomplete", comment: "")
    static let Success = NSLocalizedString("Success", comment: "")
    static let Alert = NSLocalizedString("Alert", comment: "")
    static let Failed = NSLocalizedString("Failed", comment: "")
    
    static let MissingData = NSLocalizedString("Missing data in the request.", comment: "")
    static let NoInternet = NSLocalizedString("Internet connection offline.", comment: "")
    
    static let FullNameEmpty = NSLocalizedString("Please enter fullname.", comment: "")
    static let FirstNameEmpty = NSLocalizedString("Please enter firstname.", comment: "")
    static let LastNameEmpty = NSLocalizedString("Please enter lastname.", comment: "")
    static let EmailEmpty = NSLocalizedString("Please enter email address.", comment: "")
    static let PasswordEmpty = NSLocalizedString("Please enter password.", comment: "")
    
    static let InvalidEmail = NSLocalizedString("Invalid email address.", comment: "")
    static let InvalidPassword = NSLocalizedString("Invalid password.", comment: "")
    
}
