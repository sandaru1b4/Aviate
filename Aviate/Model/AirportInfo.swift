//
//  AirportInfo.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import Foundation

struct AirportInfo: Codable {
    let airport: String?
    let timezone: String?
    let iata: String?
    let icao: String?
    let terminal: String?
    let gate: String?
    let delay: Int?
    let scheduled: String?
    let estimated: String?
    let actual: String?
    let estimatedRunway: String?
    let actualRunway: String?
    
    enum CodingKeys: String, CodingKey {
        case airport, timezone, iata, icao, terminal, gate, delay
        case scheduled, estimated, actual
        case estimatedRunway = "estimated_runway"
        case actualRunway = "actual_runway"
    }
}
