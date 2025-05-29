//
//  ErrorView.swift
//  Aviate
//
//  Created by Admin on 2025-05-29.
//

import SwiftUI

struct ErrorView: View {
    let error: Error
    let retryAction: (() -> ())?
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundStyle(.red)
            
            Text("Error loading data")
                .font(.title)
            
            Text(error.localizedDescription)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            
            Button(action: {
                retryAction?()
            }) {
                Text("Retry")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ErrorView(error: AppError.message(""), retryAction: {})
}
