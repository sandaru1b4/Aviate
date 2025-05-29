//
//  FlightDataVM.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import Foundation

class FlightDataVM: BaseVM {
    
    //MARK: PROPERTIES
    @Published var flights: [FlightData] = []
    @Published var error: Error?
    @Published var selectedFlight: FlightData?
    @Published var pagination = Pagination(offset: 0, limit: 100, count: 0, total: 0)
    @Published var flightStatusFilter: String?
    
    private let apiService: AviationAPIServiceProtocol
    private let airlineIATA: String?
    
    init(airlineIATA: String?, apiService: AviationAPIServiceProtocol = AviationAPIService()) {
        self.airlineIATA = airlineIATA
        self.apiService = apiService
    }
}


extension FlightDataVM {
    
    @MainActor
    func fetchFlights() async {
        if flights.isEmpty {
            startLoading()
        }
        error = nil
        
        do {
            let response = try await apiService.fetchFlights(
                airlineIATA: airlineIATA,
                flightStatus: flightStatusFilter,
                offset: pagination.offset,
                limit: pagination.limit
            )
            guard let flights = response else { throw AppError.message("Flights not found")}
            self.flights.append(contentsOf: flights)
            pagination.count = flights.count
            if let total = pagination.total, let offset = pagination.offset {
                pagination.total = max(total, flights.count + offset)
            }
        } catch let error as APIError {
            self.error = error
        } catch {
            self.error = error
            self.handleErrorAndShowAlert(error: error)
        }
        
        stopLoading()
        isLoading = false
    }
    
    func fetchFlightDetails(flightNumber: String) async {
        isLoading = true
        error = nil
        
        do {
            let flight = try await apiService.fetchFlightDetails(flightNumber: flightNumber)
            self.selectedFlight = flight
        } catch let error as APIError {
            self.error = error
        } catch {
            self.error = error
            self.handleErrorAndShowAlert(error: error)
        }
        
        isLoading = false
    }
    
    func loadMoreFlights(currentItem: FlightData?) async {
        guard let currentItem = currentItem else {
            await fetchFlights()
            return
        }
        
        let thresholdIndex = flights.index(flights.endIndex, offsetBy: -5)
        if flights.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex {
            if let offset = pagination.offset, let limit = pagination.limit {
                isLoading = true
                pagination.offset! += limit
            }
            await fetchFlights()
        }
    }
    
}
