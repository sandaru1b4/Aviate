//
//  ArrivalDetailSection.swift
//  Aviate
//
//  Created by Admin on 2025-05-29.
//

import SwiftUI

struct ArrivalDetailSection: View {
    let title: String
    let info: Arrival?
    
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
    ArrivalDetailSection(title: "", info: nil)
}
