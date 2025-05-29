//
//  DepartureDetailsSection.swift
//  Aviate
//
//  Created by Admin on 2025-05-29.
//

import SwiftUI

struct DepartureDetailSection: View {
    let title: String
    let info: Departure?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 4) {
                if let airport = info?.airport {
                    DetailRow(icon: "airplane", text: airport)
                }
                
                if let terminal = info?.terminal, let gate = info?.gate {
                    DetailRow(icon: "signpost.right", text: "Terminal \(terminal), Gate \(gate)")
                }
                
                if let scheduled = info?.scheduled {
                    DetailRow(icon: "clock", text: "Scheduled: \(scheduled)")
                }
                
                if let estimated = info?.estimated {
                    DetailRow(icon: "clock.badge.exclamationmark", text: "Estimated: \(estimated)")
                }
                
                if let delay = info?.delay, delay > 0 {
                    DetailRow(icon: "exclamationmark.triangle", text: "Delayed by \(delay) minutes")
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            .padding(.horizontal)
        }
    }
}

#Preview {
    DepartureDetailSection(title: "Departure 1", info: .init(airport: "JFK", terminal: "1", gate: "23", scheduled: "2025-05-29T10:30:00Z", estimated: "2025-05-29T10:25:00Z"))
}
