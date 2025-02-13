//
//  Place.swift
//  PlaceFinder
//
//  Created by Md Alif Hossain on 13/2/25.
//

import Foundation

//struct Place: Codable, Identifiable {
//    var id = UUID()
//    let name: String
//    let geometry: Geometry
//}

struct Place: Codable, Identifiable {
    let id: String  // Use place_id as the identifier
    let name: String
    let geometry: Geometry

    enum CodingKeys: String, CodingKey {
        case id = "place_id"  // Map id to place_id
        case name
        case geometry
    }
}
