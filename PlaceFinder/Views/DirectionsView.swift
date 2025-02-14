//
//  DirectionsView.swift
//  PlaceFinder
//
//  Created by Md Alif Hossain on 14/2/25.
//

import SwiftUI
import CoreLocation

struct DirectionsView: View {
    @StateObject private var viewModel = DirectionsViewModel()
    @StateObject private var locationManager = LocationManager()
    @State private var selectedLocation: CLLocationCoordinate2D?
    
    var userLocation: CLLocationCoordinate2D? {
        locationManager.userLocation
    }
    let destinationLocation: CLLocationCoordinate2D
    
    init(destinationLocation: CLLocationCoordinate2D) {
        self.destinationLocation = destinationLocation
    }
    
    var body: some View {
        VStack {
            if !viewModel.polylinePoints.isEmpty {
                GoogleMapView(
                    locationManager: locationManager,
                    selectedLocation: $selectedLocation
                )
                .onAppear {
                    selectedLocation = destinationLocation
                }
            } else {
                Text("Fetching directions...")
                    .onAppear {
                        if let userLocation = userLocation { 
                            viewModel.openGoogleMaps(from: userLocation, to: destinationLocation)
                        }
                    }
                
                Button(action: {
                    if let userLocation = userLocation {
                        viewModel.openGoogleMaps(from: userLocation, to: destinationLocation)
                    }
                }) {
                    Text("Open in Google Maps")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
            }
        }
        .navigationTitle("Directions")
    }
}
