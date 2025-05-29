//
//  FlightDataView.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import SwiftUI

struct FlightDataView: View {
    
    //MARK: PROPERTIES
    let airlineIATA: String
    @StateObject private var vm: FlightDataVM
    @EnvironmentObject var appManager: AppManager
    
    init(airlineIATA: String?) {
        self.airlineIATA = airlineIATA ?? ""
        self._vm = StateObject(wrappedValue: FlightDataVM(airlineIATA: airlineIATA))
    }
    
    var body: some View {
        
        ZStack {
            
            // MARK: - BACKGROUND
            Color.white.ignoresSafeArea()
            
            
            VStack(spacing: 0) {
                
                NavigationBarView(title: "Flights") {}
                    .padding(.horizontal, 16)
                
                if let error = vm.error {
                    Spacer()
                    ErrorView(error: error, retryAction: {
                        Task {
                            await vm.fetchFlights()
                        }
                    })
                    Spacer()
                } else if vm.flights.isEmpty {
                    Spacer()
                    EmptyStateView(message: "No flights found for this airline")
                    Spacer()
                } else {
                    ScrollView {
                        
                        LazyVStack(spacing: 16) {
                            ForEach(vm.flights, id: \.id) { flight in
                                FlightRowView(flight: flight)
                                    .onTapGesture {
                                        appManager.navigate(to: .flightSchedule, flight)
                                    }
                                    .task {
                                        await vm.loadMoreFlights(currentItem: flight)
                                    }
                            }
                            
                            //bottom activity indicator when pagination
                            if vm.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: Color.custom(.primaryAppColor)))
                            }
                        }
                        .padding(.bottom, 30)
                        .padding([.horizontal, .top], 16)
                        
                    } //: ScrollView
                    .scrollIndicators(.hidden)
                }
                
                
            } //: VStack
        }
        .toolbar(.hidden, for: .navigationBar)
        .task {
            await vm.fetchFlights()
        }
        
    }
}

#Preview {
    FlightDataView(airlineIATA: "")
}
