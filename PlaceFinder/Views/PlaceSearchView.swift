//
//  PlaceSearchView.swift
//  PlaceFinder
//
//  Created by Md Alif Hossain on 13/2/25.
//

import SwiftUI
import CoreLocation

struct PlaceSearchView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = PlaceSearchViewModel()
    @Binding var selectedLocation: CLLocationCoordinate2D?
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search for a place...", text: $viewModel.query)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                List(viewModel.searchResults, id: \.id) { place in
                    Button(action: {
                        viewModel.selectLocation(for: place)
                        selectedLocation = viewModel.selectedLocation
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text(place.name)
                    }
                }
            }
        }
    }
}
