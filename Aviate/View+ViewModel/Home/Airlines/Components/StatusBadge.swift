//
//  StatusBadge.swift
//  Aviate
//
//  Created by Admin on 2025-05-29.
//

import SwiftUI

struct StatusBadge: View {
    let status: String
    
    var backgroundColor: Color {
        switch status.lowercased() {
        case "scheduled": return .blue
        case "active": return .green
        case "landed": return .orange
        case "cancelled": return .red
        case "incident": return .purple
        case "diverted": return .yellow
        default: return .gray
        }
    }
    
    var body: some View {
        Text(status.capitalized)
            .font(.caption)
            .fontWeight(.bold)
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .background(backgroundColor)
            .foregroundStyle(.white)
            .cornerRadius(12)
    }
}

#Preview {
    StatusBadge(status: "scheduled")
}
