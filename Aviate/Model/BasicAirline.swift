//
//  BasicAirline.swift
//  Aviate
//
//  Created by Admin on 2025-05-29.
//

import Foundation

struct BasicAirline: Codable {

    var name: String?
    var iata: String?
    var icao: String?

    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case iata = "iata"
        case icao = "icao"
    }

}
