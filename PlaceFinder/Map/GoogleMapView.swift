//
//  GoogleMapView.swift
//  PlaceFinder
//
//  Created by Md Alif Hossain on 13/2/25.
//

import SwiftUI
import GoogleMaps

struct GoogleMapView: UIViewRepresentable {
    @ObservedObject var locationManager: LocationManager

    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView()
        mapView.settings.myLocationButton = true // Show location button
        mapView.isMyLocationEnabled = true // Enable blue dot for user location
        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        if let location = locationManager.userLocation {
            let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 15)
            uiView.animate(to: camera)
        }
    }
}
