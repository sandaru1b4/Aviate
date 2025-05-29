//
//  AirlineRowView.swift
//  Aviate
//
//  Created by Admin on 2025-05-29.
//

import SwiftUI

struct AirlineRowView: View {
    let airline: Airline
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            // Airline logo placeholder with IATA code
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 40, height: 40)
                
                if let iataCode = airline.iataCode {
                    Text(iataCode)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.blue)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(airline.airlineName ?? "Unknown Airline")
                    .font(.headline)
                    .lineLimit(1)
                
                if let country = airline.countryName {
                    Text(country)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
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
    AirlineRowView(airline: Airline(id: nil, fleetAverageAge: nil, airlineId: nil, callsign: nil, hubCode: nil, iataCode: nil, icaoCode: nil, countryIso2: nil, dateFounded: nil, iataPrefixAccounting: nil, airlineName: nil, countryName: nil, fleetSize: nil, status: nil, type: nil))
}
