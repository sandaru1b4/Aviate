//
//  LoadingIndicatorDelegate.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import Foundation
import SwiftUI
import RappleProgressHUD

protocol LoadingIndicatorDelegate {
    func startLoading()
    func stopLoading()
}

extension LoadingIndicatorDelegate {
    // -------- RappleProgressHUD -------- //
    // Start loading
    func startLoading() {
        let attributes = RappleActivityIndicatorView.attribute(style: RappleStyle.apple, tintColor: UIColor(Color.custom(.primaryAppColor)), progressBG: .clear , thickness: 4)
        RappleActivityIndicatorView.startAnimating(attributes: attributes)
    }
    // Stop loading
    func stopLoading() {
        RappleActivityIndicatorView.stopAnimation()
    }
}


