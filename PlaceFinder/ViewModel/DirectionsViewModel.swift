//
//  DirectionsViewModel.swift
//  PlaceFinder
//
//  Created by Md Alif Hossain on 14/2/25.
//

import Alamofire
import CoreLocation

class DirectionsViewModel: ObservableObject {
    @Published var polylinePoints: String = ""
    @Published var selectedLocation: CLLocationCoordinate2D?
    @Published var userLocation: CLLocationCoordinate2D?
    let locationManager = LocationManager()
    
    init() {
        self.userLocation = locationManager.userLocation
    }
    
    func getDirections(from start: CLLocationCoordinate2D, to end: CLLocationCoordinate2D) {
        let apiKey = "AIzaSyB36Rtl4Pab5g-hSgXZZICQZzLG7vxQgTw"
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(start.latitude),\(start.longitude)&destination=\(end.latitude),\(end.longitude)&mode=driving&key=\(apiKey)"
        
        AF.request(url)
            .validate()
            .responseDecodable(of: DirectionsResponse.self) { response in
                switch response.result {
                case .success(let directions):
                    if let points = directions.routes.first?.overviewPolyline.points {
                        DispatchQueue.main.async {
                            self.polylinePoints = points
                        }
                    }
                case .failure(let error):
                    print("Error fetching directions: \(error.localizedDescription)")
                    
                }
            }
    }
}
