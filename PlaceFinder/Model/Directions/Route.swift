//
//  Route.swift
//  PlaceFinder
//
//  Created by Md Alif Hossain on 14/2/25.
//

import Foundation

struct Route: Codable {
    let overviewPolyline: OverviewPolyline

    enum CodingKeys: String, CodingKey {
        case overviewPolyline = "overview_polyline"
    }
}
