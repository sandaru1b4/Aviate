//
//  AlertShowable.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import Foundation

protocol AlertShowable: AnyObject {
    var alertTitle: String { get set }
    var alertMessage: String { get set }
    var isShowAlert: Bool { get set }
    var statusCode: Int { get set }
    func showAlert(title: String, message: String, _ code: Int)
    func showErrorAlert(_ message: String, _ code: Int)
}

extension AlertShowable {
    func showAlert(title: String, message: String, _ code: Int) {
        if code != 300 {
            if message == "The email address you have entered has already been registered" {
                alertTitle = "Email Registered"
            } else {
                alertTitle = .Error
            }
        } else {
            alertTitle = title
        }
        alertMessage = message
        isShowAlert = true
        statusCode = code
    }
    
    func showErrorAlert(_ message: String, _ code: Int) {
        isShowAlert = true
        alertMessage = message
        alertTitle = .Error
        statusCode = code
    }
}
