//
//  ContentView.swift
//  PlaceFinder
//
//  Created by Md Alif Hossain on 13/2/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        GoogleMapView(locationManager: locationManager)
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
