//
//  HomeViewModel.swift
//  PlaceFinder
//
//  Created by Md Alif Hossain on 15/2/25.
//

import CoreLocation

class HomeViewModel: ObservableObject {
    @Published var selectedLocation: CLLocationCoordinate2D?
    @Published var showSearch = false
    @Published var showDirections = false
    let locationManager: LocationManager
    
    init(
        locationManager: LocationManager = LocationManager()
    ) {
            self.locationManager = locationManager
        }
    
    func updateSelectedLocation(_ location: CLLocationCoordinate2D?) {
        selectedLocation = location
        if location != nil {
            showDirections = true
        }
    }
}
