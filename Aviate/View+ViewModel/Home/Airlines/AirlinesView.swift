//
//  AirlinesView.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import SwiftUI

struct AirlinesView: View {
    
    //MARK: PROPERTIES
    @StateObject private var vm = AirlinesVM()
    @EnvironmentObject var appManager: AppManager
    
    var body: some View {
        
        ZStack {
            
            // MARK: - BACKGROUND
            Color.white.ignoresSafeArea()
            
            
            VStack(spacing: 0) {
                
                Group {
                    NavigationBarView(isShowBackButton: false, title: "Airlines") {}
                    
                    
                    SearchBarView(searchText: $vm.searchText)
                }
                .padding(.horizontal, 16)
                
                if let error = vm.error {
                    Spacer()
                    ErrorView(error: error, retryAction: {
                        Task {
                            await vm.fetchAirlines()
                        }
                    })
                    Spacer()
                } else if vm.filteredAirlines.isEmpty {
                    Spacer()
                    EmptyStateView()
                    Spacer()
                } else {
                    ScrollView {
                        
                        LazyVStack(spacing: 16) {
                            ForEach(vm.filteredAirlines, id: \.id) { airline in
                                AirlineRowView(airline: airline)
                                    .onTapGesture {
                                        guard let iata = airline.iataCode else { return }
                                        appManager.navigate(to: .flightData, iata)
                                    }
                                    .task {
                                        await vm.loadMoreAirlines(currentItem: airline)
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
            if vm.airlines.isEmpty {
                await vm.fetchAirlines()
            }
        }
    }
}
