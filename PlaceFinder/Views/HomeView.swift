//
//  ContentView.swift
//  PlaceFinder
//
//  Created by Md Alif Hossain on 13/2/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        ZStack {
            GoogleMapView(locationManager: viewModel.locationManager, selectedLocation: $viewModel.selectedLocation)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                Button(action: { viewModel.showSearch = true }) {
                    Text("Search Place")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .padding()
            }
        }
        .sheet(isPresented: $viewModel.showSearch) {
            PlaceSearchView(selectedLocation: $viewModel.selectedLocation)
        }
        .onChange(of: viewModel.selectedLocation) {
            if viewModel.selectedLocation != nil {
                viewModel.showDirections = true
            }
        }
        .fullScreenCover(isPresented: $viewModel.showDirections) {
            if let destination = viewModel.selectedLocation {
                DirectionsView(destinationLocation: destination)
            }
        }
    }
}
