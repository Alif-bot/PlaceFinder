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
    let destinationLocation: CLLocationCoordinate2D
    
    var body: some View {
        VStack {
            GoogleMapView(
                locationManager: viewModel.locationManager,
                selectedLocation: $viewModel.selectedLocation,
                polylinePoints: viewModel.polylinePoints
            )
            .onAppear {
                if let userLocation = viewModel.locationManager.userLocation {
                    viewModel.getDirections(from: userLocation, to: destinationLocation)
                }
                viewModel.selectedLocation = destinationLocation
            }
            
            Button(action: {
                if let userLocation = viewModel.locationManager.userLocation {
                    viewModel.getDirections(from: userLocation, to: destinationLocation)
                }
            }) {
                Text("Find Route")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .navigationTitle("Directions")
    }
}
