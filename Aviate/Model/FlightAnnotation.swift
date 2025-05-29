//
//  FlightAnnotation.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import MapKit

struct FlightAnnotation: Identifiable {
    let id = UUID()
    let title: String
    let coordinate: CLLocationCoordinate2D
}
