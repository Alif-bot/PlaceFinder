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
    @State private var hasSetInitialLocation = false
    @Binding var selectedLocation: CLLocationCoordinate2D?
    var polylinePoints: String?

    let mapView = GMSMapView()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func makeUIView(context: Context) -> GMSMapView {
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        mapView.settings.tiltGestures = true
        mapView.settings.rotateGestures = true

        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        // Move to user's current location when first available
        if let userLocation = locationManager.userLocation, !hasSetInitialLocation {
            let camera = GMSCameraPosition.camera(
                withLatitude: userLocation.latitude,
                longitude: userLocation.longitude,
                zoom: 15
            )
            uiView.animate(to: camera)
            context.coordinator.hasSetInitialLocation = true // Prevent re-centering on every update
        }
        // Move to searched location when selected
        if let searchedLocation = selectedLocation {
            let camera = GMSCameraPosition.camera(
                withLatitude: searchedLocation.latitude,
                longitude: searchedLocation.longitude,
                zoom: 15
            )
            uiView.animate(to: camera)
            
            // Add marker for searched location
            let marker = GMSMarker(position: searchedLocation)
            marker.title = "Searched Location"
            marker.map = uiView
        }
        
        // Draw route if polyline points exist
        if let polylinePoints = polylinePoints {
            drawPath(from: polylinePoints, mapView: uiView)
        }
    }

    func drawPath(from polyline: String, mapView: GMSMapView) {
        let path = GMSPath(fromEncodedPath: polyline)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 5.0
        polyline.strokeColor = .blue
        polyline.map = mapView
    }
    
    //Use Coordinator to store state safely
    class Coordinator {
        var hasSetInitialLocation = false
    }
}
