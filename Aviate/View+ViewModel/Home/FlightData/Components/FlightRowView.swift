//
//  FlightRowView.swift
//  Aviate
//
//  Created by Admin on 2025-05-29.
//

import SwiftUI

struct FlightRowView: View {
    let flight: FlightData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                StatusBadge(status: flight.flightStatus ?? "")
                
                Text("Flight \(flight.flight?.iata ?? flight.flight?.icao ?? "N/A")")
                    .font(.headline)
                
                Spacer()
                
                Text(flight.flightDate ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(flight.departure?.airport ?? "Unknown")
                        .font(.subheadline)
                    
                    if let scheduled = flight.departure?.scheduled {
                        Text(scheduled)
                            .font(.caption)
                    }
                }
                
                Image(systemName: "airplane")
                    .foregroundStyle(.blue)
                
                VStack(alignment: .trailing) {
                    Text(flight.arrival?.airport ?? "Unknown")
                        .font(.subheadline)
                    
                    if let scheduled = flight.arrival?.scheduled {
                        Text(scheduled)
                            .font(.caption)
                    }
                }
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
}

#Preview {
    FlightRowView(flight: FlightData(id: UUID(), flightDate: nil, flightStatus: nil, departure: nil, arrival: nil, airline: nil, flight: nil))
}
