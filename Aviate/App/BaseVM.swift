//
//  BaseVM.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import Foundation
import SystemConfiguration

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
   
    func handleErrorAndShowAlert(error: Error?) {
        handleErrorResponse(error) { [weak self] (status, statusCode, message) in
            self?.showAlert(title: self?.alertTitle ?? .Error, message: message, statusCode)
            self?.stopLoading()
        }
    }
    
    func checkInternetConnection() throws {
        guard isInternetAvailable() else {
            throw AppError.noInternet()
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
        } else if error != nil {
            completion(false, 401, error?.localizedDescription ?? "")
        } else {
            debugPrint("Could not infer error")
            completion(false, 400, "Unknown error occurred.")
        }
    }
}

extension BaseVM {
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}
