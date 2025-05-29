//
//  FlightScheduleView.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import SwiftUI
import MapKit

struct FlightDetailView: View {
    let flight: FlightData?
    @State private var region: MKCoordinateRegion
    @State private var annotations: [FlightAnnotation]
    
    // camera position
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    init(flight: FlightData?) {
        self.flight = flight
        
        // Default to midpoint between departure and arrival
        let depLat = Double(flight?.departure?.airport?.split(separator: ",").first ?? "0") ?? 0
        let depLon = Double(flight?.departure?.airport?.split(separator: ",").last ?? "0") ?? 0
        let arrLat = Double(flight?.arrival?.airport?.split(separator: ",").first ?? "0") ?? 0
        let arrLon = Double(flight?.arrival?.airport?.split(separator: ",").last ?? "0") ?? 0
        
        let midLat = (depLat + arrLat) / 2
        let midLon = (depLon + arrLon) / 2
        
        self._region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: midLat, longitude: midLon),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        ))
        
        self._annotations = State(initialValue: [
            FlightAnnotation(
                title: "Departure: \(flight?.departure?.airport ?? "")",
                coordinate: CLLocationCoordinate2D(latitude: depLat, longitude: depLon)
            ),
            FlightAnnotation(
                title: "Arrival: \(flight?.arrival?.airport ?? "")",
                coordinate: CLLocationCoordinate2D(latitude: arrLat, longitude: arrLon)
            )
        ])
    }
    
    var body: some View {
        
        ZStack {
            
            // MARK: - BACKGROUND
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                NavigationBarView(title: "Flight Schedule") {}
                    .padding(.horizontal, 16)
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Flight header
                        VStack(spacing: 8) {
                            Text("Flight \(flight?.flight?.iata ?? flight?.flight?.icao ?? "N/A")")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            Text(flight?.airline?.name ?? "Unknown Airline")
                                .font(.title2)
                                .foregroundStyle(.secondary)
                            
                            StatusBadge(status: flight?.flightStatus ?? "")
                        }
                        .padding(.top)
                        
                        // Map view
                        Map(position: $cameraPosition) {
                            ForEach(annotations) { annotation in
                                Marker(annotation.title, coordinate: annotation.coordinate)
                                    .tint(.blue)
                            }
                        }
                        .frame(height: 300)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .mapControls {
                            MapUserLocationButton()
                            MapCompass()
                            MapScaleView()
                        }
                        
                        // Flight details
                        VStack(spacing: 16) {
                            DepartureDetailSection(title: "Departure", info: flight?.departure)
                            ArrivalDetailSection(title: "Arrival", info: flight?.arrival)
                            
                            HStack {
                                DetailCard(title: "Date", value: flight?.flightDate ?? "", icon: "calendar")
                                DetailCard(title: "Status", value: flight?.flightStatus?.capitalized, icon: "checkmark.circle")
                            }
                            .padding(.horizontal)
                        }
                        
                        Spacer()
                    }
                }//:ScrollView
                .scrollIndicators(.hidden)
                
                
            } //: VStack
        }
        .toolbar(.hidden, for: .navigationBar)
        
    }
}
