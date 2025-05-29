//
//  EmptyStateView.swift
//  Aviate
//
//  Created by Admin on 2025-05-29.
//

import SwiftUI

struct EmptyStateView: View {
    var message: String = "No data available"
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "airplane")
                .font(.system(size: 48))
                .foregroundStyle(.blue)
            
            Text(message)
                .font(.title2)
            
            Text("Try again later or check your connection")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

#Preview {
    EmptyStateView()
}
