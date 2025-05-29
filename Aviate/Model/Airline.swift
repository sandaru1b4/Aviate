//
//  Airline.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import Foundation

struct Airline: Codable, Identifiable {
    var id: String?
    var fleetAverageAge: String?
    var airlineId: String?
    var callsign: String?
    var hubCode: String?
    var iataCode: String?
    var icaoCode: String?
    var countryIso2: String?
    var dateFounded: String?
    var iataPrefixAccounting: String?
    var airlineName: String?
    var countryName: String?
    var fleetSize: String?
    var status: String?
    var type: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case fleetAverageAge = "fleet_average_age"
        case airlineId = "airline_id"
        case callsign = "callsign"
        case hubCode = "hub_code"
        case iataCode = "iata_code"
        case icaoCode = "icao_code"
        case countryIso2 = "country_iso2"
        case dateFounded = "date_founded"
        case iataPrefixAccounting = "iata_prefix_accounting"
        case airlineName = "airline_name"
        case countryName = "country_name"
        case fleetSize = "fleet_size"
        case status = "status"
        case type = "type"
    }
}
