//
//  AirlineResponse.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import Foundation

struct AirlineResponse: Codable {
    var pagination: Pagination?
    var data: [Airline]?
    
    private enum CodingKeys: String, CodingKey {
        case pagination = "pagination"
        case data = "data"
    }
}
