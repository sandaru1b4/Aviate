//
//  AirlinesVM.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import Foundation
import FirebaseAuth

class AirlinesVM: BaseVM {
    
    @Published var airlines: [Airline] = []
    @Published var error: Error?
    @Published var searchText = ""
    @Published var pagination = Pagination(offset: 0, limit: 100, count: 0, total: 0)
    
    @Published var isLogoutAlert = false
    
    private let apiService: AviationAPIServiceProtocol
    
    init(apiService: AviationAPIServiceProtocol = AviationAPIService()) {
        self.apiService = apiService
    }
}

extension AirlinesVM {
    
    @MainActor
    func fetchAirlines() async {
        if airlines.isEmpty {
            startLoading()
        }
        error = nil
        do {
            let response = try await apiService.fetchAirlines(offset: pagination.offset, limit: pagination.limit)
            
            guard let airlines = response else { throw AppError.message("Airlines not found")}
            self.airlines.append(contentsOf: airlines)
            pagination.count = airlines.count
            if let total = pagination.total, let offset = pagination.offset {
                pagination.total = max(total, airlines.count + offset)
            }
        } catch let error as APIError {
            self.error = error
        } catch {
            self.error = error
            self.handleErrorAndShowAlert(error: error)
        }
        isLoading = false
        stopLoading()
    }
    
    @MainActor
    func loadMoreAirlines(currentItem: Airline?) async {
        guard let currentItem = currentItem else {
            await fetchAirlines()
            return
        }
        
        let thresholdIndex = airlines.index(airlines.endIndex, offsetBy: -5)
        if airlines.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex {
            if let offset = pagination.offset, let limit = pagination.limit {
                isLoading = true
                pagination.offset! += limit
            }
            await fetchAirlines()
        }
    }
    
    var filteredAirlines: [Airline] {
        if searchText.isEmpty {
            return airlines
        } else {
            return airlines.filter { airline in
                airline.airlineName?.localizedCaseInsensitiveContains(searchText) ?? false ||
                airline.iataCode?.localizedCaseInsensitiveContains(searchText) ?? false
            }
        }
    }
    
    
    @MainActor
    func proceedLogout() async throws {
        do {
            try checkInternetConnection()
            try Auth.auth().signOut()
            AppManager.shared.signOut()
        } catch {
            throw error
        }
    }
    
}

