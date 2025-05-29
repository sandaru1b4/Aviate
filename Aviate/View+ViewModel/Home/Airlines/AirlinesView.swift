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
                        .overlay(
                            Button(action: {
                                vm.isLogoutAlert = true
                                vm.showAlert(title: "Log Out", message: "Are you sure you want log out?", 300)
                            }) {
                                Text("Log Out")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundStyle(Color.custom(.primaryAppColor))
                            }
                                .padding(.trailing, 10)
                            ,
                            alignment: .trailing
                        )
                    
                    
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
        .alert(
            vm.alertTitle,
            isPresented: $vm.isShowAlert,
            actions: {
                if vm.isLogoutAlert {
                    Button("Cancel", role: .cancel) {
                        vm.isLogoutAlert = false
                    }
                    Button("LogOut", role: .destructive) {
                        vm.isLogoutAlert = false
                        proceedLogOut()
                    }
                } else {
                    Button("Ok", role: .cancel) {
                        vm.isLogoutAlert = false
                    }
                }
            },
            message: {
                Text(vm.alertMessage)
            }
        )
//        .task {
//            if vm.airlines.isEmpty {
//                await vm.fetchAirlines()
//            }
//        }
    }
}

extension AirlinesView {
    private func proceedLogOut() {
        Task {
            vm.startLoading()
            do {
                
                try await vm.proceedLogout()
                self.appManager.navigateToRoot()
                
            } catch {
                vm.handleErrorAndShowAlert(error: error)
            }
            vm.stopLoading()
        }
    }
}
