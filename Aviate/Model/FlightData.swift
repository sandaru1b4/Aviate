//
//  FlightData.swift
//  Aviate
//
//  Created by Admin on 2025-05-29.
//

import Foundation

struct FlightData: Codable, Identifiable {

    var id = UUID()
    var flightDate: String?
    var flightStatus: String?
    var departure: Departure?
    var arrival: Arrival?
    var airline: BasicAirline?
    var flight: Flight?
//    var aircraft: Any?
//    var live: Any?

    private enum CodingKeys: String, CodingKey {
        case flightDate = "flight_date"
        case flightStatus = "flight_status"
        case departure = "departure"
        case arrival = "arrival"
        case airline = "airline"
        case flight = "flight"
//        case aircraft = "aircraft"
//        case live = "live"
    }

}
