//
//  FlightResponse.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import Foundation

struct FlightResponse: Codable {
    let pagination: Pagination
    let data: [FlightData]
}
