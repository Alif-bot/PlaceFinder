//
//  ContentView.swift
//  PlaceFinder
//
//  Created by Md Alif Hossain on 13/2/25.
//

import SwiftUI
import GoogleMaps
import CoreLocation

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    @State private var selectedLocation: CLLocationCoordinate2D?
    @State private var showSearch = false
    @State private var showDirections = false

    var body: some View {
        ZStack {
            GoogleMapView(locationManager: locationManager, selectedLocation: $selectedLocation)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                Button(action: { showSearch = true }) {
                    Text("Search Place")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .padding()
            }
        }
        .sheet(isPresented: $showSearch) {
            PlaceSearchView(selectedLocation: $selectedLocation)
        }
        .onChange(of: selectedLocation) { newLocation in
            if newLocation != nil {
                showDirections = true
            }
        }
        .fullScreenCover(isPresented: $showDirections) {
            if let destination = selectedLocation {
                DirectionsView(destinationLocation: destination)
            }
        }
    }
}
