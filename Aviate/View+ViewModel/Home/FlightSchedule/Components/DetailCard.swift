//
//  DetailCard.swift
//  Aviate
//
//  Created by Admin on 2025-05-29.
//

import SwiftUI

struct DetailCard: View {
    let title: String
    let value: String?
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(title, systemImage: icon)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Text(value ?? "")
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    DetailCard(title: "", value: nil, icon: "")
}
