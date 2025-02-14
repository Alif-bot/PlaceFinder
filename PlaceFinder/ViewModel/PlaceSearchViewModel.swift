//
//  PlaceSearchViewModel.swift
//  PlaceFinder
//
//  Created by Md Alif Hossain on 13/2/25.
//

//import Foundation
//import Combine
//import Alamofire
//
//class PlaceSearchViewModel: ObservableObject {
//    @Published var searchResults: [Place] = []
//    private var cancellables = Set<AnyCancellable>()
//    
//    let apiKey = "AIzaSyB36Rtl4Pab5g-hSgXZZICQZzLG7vxQgTw"
//
//    func searchPlaces(query: String) {
//        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
//            print("Invalid query")
//            return
//        }
//        
//        let urlString = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(encodedQuery)&key=\(apiKey)"
//        
//        AF.request(urlString)
//            .validate()
//            .publishData()
//            .tryMap { response -> Data in
//                if let error = response.error {
//                    throw error
//                }
//                return response.data ?? Data()
//            }
//            .handleEvents(receiveOutput: { data in
//                let jsonString = String(data: data, encoding: .utf8)
//                print("API Response: \(jsonString ?? "No Data")")
//            })
//            .decode(type: PlaceResponse.self, decoder: JSONDecoder())
//            .replaceError(with: PlaceResponse(results: []))
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] response in
//                print("Decoded Places: \(response.results)")
//                self?.searchResults = response.results
//            }
//            .store(in: &cancellables)
//    }
//}


import Foundation
import Combine
import Alamofire
import CoreLocation

class PlaceSearchViewModel: ObservableObject {
    @Published var searchResults: [Place] = []
    @Published var query: String = "" {
        didSet {
            searchPlaces(query: query)
        }
    }
    var selectedLocation: CLLocationCoordinate2D?
    private var cancellables = Set<AnyCancellable>()
    
    let apiKey = "AIzaSyB36Rtl4Pab5g-hSgXZZICQZzLG7vxQgTw"

    func searchPlaces(query: String) {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Invalid query")
            return
        }
        
        let urlString = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(encodedQuery)&key=\(apiKey)"
        
        AF.request(urlString)
            .validate()
            .publishData()
            .tryMap { response -> Data in
                if let error = response.error {
                    throw error
                }
                return response.data ?? Data()
            }
            .handleEvents(receiveOutput: { data in
                let jsonString = String(data: data, encoding: .utf8)
                print("API Response: \(jsonString ?? "No Data")")
            })
            .decode(type: PlaceResponse.self, decoder: JSONDecoder())
            .replaceError(with: PlaceResponse(results: []))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in
                print("Decoded Places: \(response.results)")
                self?.searchResults = response.results
            }
            .store(in: &cancellables)
    }
    
    func selectLocation(for place: Place) {
        selectedLocation = CLLocationCoordinate2D(latitude: place.geometry.location.lat, longitude: place.geometry.location.lng)
    }
}

