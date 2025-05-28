//
//  BaseVM.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import Foundation

class BaseVM: NSObject, ObservableObject, LoadingIndicatorDelegate, AlertShowable {
    
    //: ALERTS
    @Published var isShowAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var statusCode: Int = 0
    
    @Published var isLoading = false
    
}

// MARK: - Error Handling
extension BaseVM {
    
    func showNoInternetAlert() {
        showAlert(title: .Error, message: .NoInternet, 0)
    }
    
    func handleErrorAndShowAlert(error: Error?) {
        handleErrorResponse(error) { [weak self] (status, statusCode, message) in
            self?.showAlert(title: self?.alertTitle ?? .Error, message: message, statusCode)
            self?.stopLoading()
        }
    }
}

extension BaseVM {
    func handleErrorResponse(_ error: Error?, completion: CompletionHandler) {
        if let errorResponse = error as? AppError {
            debugPrint(errorResponse)
            completion(false, 300, errorResponse.localizedDescription)
        } else if let errorResponse = error as? DecodingError {
            switch errorResponse {
            case .typeMismatch(let type, let context):
                debugPrint("Type '\(type)' mismatch: \(context.codingPath)" )
                completion(false, 422, context.debugDescription)
            default:
                debugPrint(errorResponse)
                completion(false, 422, error?.localizedDescription ?? "")
            }
        } else {
            debugPrint("Could not infer error")
            completion(false, 400, "Unknown error occurred.")
        }
    }
}
