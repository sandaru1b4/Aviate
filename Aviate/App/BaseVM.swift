//
//  BaseVM.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import Foundation

class BaseVM: NSObject, ObservableObject {
    
    //: ALERTS
    @Published var isShowAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var statusCode: Int = 0
    
    @Published var isLoading = false
    
}
