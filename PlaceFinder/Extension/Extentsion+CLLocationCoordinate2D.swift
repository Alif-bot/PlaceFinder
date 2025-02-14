//
//  Extentsion+CLLocationCoordinate2D.swift
//  PlaceFinder
//
//  Created by Md Alif Hossain on 14/2/25.
//

import CoreLocation

extension CLLocationCoordinate2D: @retroactive Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
