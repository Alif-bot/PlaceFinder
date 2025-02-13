//
//  PlaceSearchView.swift
//  PlaceFinder
//
//  Created by Md Alif Hossain on 13/2/25.
//

//import SwiftUI
//import CoreLocation
//
//struct PlaceSearchView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @ObservedObject var viewModel = PlaceSearchViewModel()
//    @Binding var selectedLocation: CLLocationCoordinate2D?
//    
//    @State private var query = ""
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                TextField("Search for a place...", text: $query, onCommit: {
//                    viewModel.searchPlaces(query: query)
//                })
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//                
//                List(viewModel.searchResults) { place in
//                    Button(action: {
//                        selectedLocation = CLLocationCoordinate2D(latitude: place.geometry.location.lat, longitude: place.geometry.location.lng)
//                        presentationMode.wrappedValue.dismiss()
//                    }) {
//                        Text(place.name)
//                    }
//                }
//            }
//            .navigationTitle("Search Places")
//        }
//    }
//}

import SwiftUI
import CoreLocation

struct PlaceSearchView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = PlaceSearchViewModel()
    @Binding var selectedLocation: CLLocationCoordinate2D?
    
    @State private var query = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search for a place...", text: $query)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: query) { newValue in
                        viewModel.searchPlaces(query: newValue)
                    }

                Button("Search") {
                    viewModel.searchPlaces(query: query)
                }
                .padding()

                List(viewModel.searchResults) { place in
                    Button(action: {
                        selectedLocation = CLLocationCoordinate2D(latitude: place.geometry.location.lat, longitude: place.geometry.location.lng)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text(place.name)
                    }
                }
            }
            .navigationTitle("Search Places")
        }
    }
}
