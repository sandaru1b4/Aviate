//
//  AviationAPIServiceProtocol.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import Foundation

protocol AviationAPIServiceProtocol {
    func fetchAirlines(offset: Int?, limit: Int?) async throws -> [Airline]?
    func fetchFlights(airlineIATA: String?, flightStatus: String?, offset: Int?, limit: Int?) async throws -> [FlightData]?
    func fetchFlightDetails(flightNumber: String) async throws -> FlightData?
}
