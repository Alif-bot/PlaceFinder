//
//  DirectionsViewModel.swift
//  PlaceFinder
//
//  Created by Md Alif Hossain on 14/2/25.
//

import SwiftUI
import Combine
import CoreLocation

class DirectionsViewModel: ObservableObject {
    @Published var polylinePoints: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    let apiKey = "AIzaSyB36Rtl4Pab5g-hSgXZZICQZzLG7vxQgTw"

    func getDirections(from origin: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        let originString = "\(origin.latitude),\(origin.longitude)"
        let destinationString = "\(destination.latitude),\(destination.longitude)"
        
        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(originString)&destination=\(destinationString)&mode=driving&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: DirectionsResponse.self, decoder: JSONDecoder())
            .replaceError(with: DirectionsResponse(routes: []))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in
                if let route = response.routes.first {
                    self?.polylinePoints = route.overviewPolyline.points
                }
            }
            .store(in: &cancellables)
    }
    
    func openGoogleMaps(from origin: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        let urlString = "comgooglemaps://?saddr=\(origin.latitude),\(origin.longitude)&daddr=\(destination.latitude),\(destination.longitude)&directionsmode=driving"
        
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            // Fallback to Google Maps in the browser
            let webURLString = "https://www.google.com/maps/dir/?api=1&origin=\(origin.latitude),\(origin.longitude)&destination=\(destination.latitude),\(destination.longitude)&travelmode=driving"
            if let webURL = URL(string: webURLString) {
                UIApplication.shared.open(webURL)
            }
        }
    }
}
