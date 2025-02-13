//
//  GoogleMapView.swift
//  PlaceFinder
//
//  Created by Md Alif Hossain on 13/2/25.
//

import SwiftUI
import GoogleMaps
import Alamofire

struct GoogleMapView: UIViewRepresentable {
    @ObservedObject var locationManager: LocationManager
    @Binding var selectedLocation: CLLocationCoordinate2D?

    let mapView = GMSMapView()

    func makeUIView(context: Context) -> GMSMapView {
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        if let userLocation = locationManager.userLocation {
            let camera = GMSCameraPosition.camera(withLatitude: userLocation.latitude, longitude: userLocation.longitude, zoom: 15)
            uiView.animate(to: camera)
        }

        if let place = selectedLocation {
            let marker = GMSMarker(position: place)
            marker.title = "Selected Place"
            marker.map = uiView

            let camera = GMSCameraPosition.camera(withLatitude: place.latitude, longitude: place.longitude, zoom: 15)
            uiView.animate(to: camera)

            // Fetch and draw route
            if let userLocation = locationManager.userLocation {
                getRoute(from: userLocation, to: place, mapView: uiView)
            }
        }
    }

    func getRoute(from start: CLLocationCoordinate2D, to end: CLLocationCoordinate2D, mapView: GMSMapView) {
        let apiKey = "YOUR_GOOGLE_MAPS_API_KEY"
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(start.latitude),\(start.longitude)&destination=\(end.latitude),\(end.longitude)&mode=driving&key=\(apiKey)"

        AF.request(url).responseJSON { response in
            guard let data = response.data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let routes = json?["routes"] as? [[String: Any]], let route = routes.first {
                    if let overviewPolyline = route["overview_polyline"] as? [String: Any],
                       let points = overviewPolyline["points"] as? String {
                        self.drawPath(from: points, mapView: mapView)
                    }
                }
            } catch {
                print("Error parsing route JSON: \(error)")
            }
        }
    }

    func drawPath(from polyline: String, mapView: GMSMapView) {
        let path = GMSPath(fromEncodedPath: polyline)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 5.0
        polyline.strokeColor = .blue
        polyline.map = mapView
    }
}
