//
//  PlaceSearchViewModel.swift
//  PlaceFinder
//
//  Created by Md Alif Hossain on 13/2/25.
//

//import SwiftUI
//import Combine
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
//        guard let url = URL(string: urlString) else { return }
//
//        URLSession.shared.dataTaskPublisher(for: url)
//            .map(\.data)
//            .handleEvents(receiveOutput: { data in
//                let jsonString = String(data: data, encoding: .utf8)
//                print("API Response: \(jsonString ?? "No Data")")
//            })
//            .decode(type: PlaceResponse.self, decoder: JSONDecoder())
//            .replaceError(with: PlaceResponse(results: []))
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] response in
//                self?.searchResults = response.results
//            }
//            .store(in: &cancellables)
//    }
//}

import SwiftUI
import Combine

class PlaceSearchViewModel: ObservableObject {
    @Published var searchResults: [Place] = []
    private var cancellables = Set<AnyCancellable>()
    
    let apiKey = "AIzaSyB36Rtl4Pab5g-hSgXZZICQZzLG7vxQgTw"

    func searchPlaces(query: String) {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Invalid query")
            return
        }
        
        let urlString = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(encodedQuery)&key=\(apiKey)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
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
}

