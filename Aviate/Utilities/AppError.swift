//
//  AppError.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import Foundation

enum AppError: Error {
    case message(_ text: String)
    case invalidEmail(message: String = .Warning.invalidEmail)
    case invalidPassword(message: String = .Warning.shortPassword)
    case noInternet(message: String = .Warning.noInternet)
}

extension AppError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .message(let text):
                return NSLocalizedString(text, comment: "")
            case .invalidEmail(let message):
                return NSLocalizedString(message, comment: "")
            case .invalidPassword(let message):
                return NSLocalizedString(message, comment: "")
            case .noInternet(message: let message):
                return NSLocalizedString(message, comment: "")
        }
    }
    public var failureReason: String? {
        switch self {
            case .message(let text):
                return NSLocalizedString(text, comment: "")
            case .invalidEmail(let message):
                return NSLocalizedString(message, comment: "")
            case .invalidPassword(let message):
                return NSLocalizedString(message, comment: "")
            case .noInternet(message: let message):
                return NSLocalizedString(message, comment: "")
        }
    }
    public var recoverySuggestion: String? {
        switch self {
            case .message(let text):
                return NSLocalizedString(text, comment: "")
            case .invalidEmail(let message):
                return NSLocalizedString(message, comment: "")
            case .invalidPassword(let message):
                return NSLocalizedString(message, comment: "")
            case .noInternet(message: let message):
                return NSLocalizedString(message, comment: "")
        }
    }
}
