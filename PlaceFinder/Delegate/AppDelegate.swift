//
//  AppDelegate.swift
//  PlaceFinder
//
//  Created by Md Alif Hossain on 13/2/25.
//

import UIKit
import GoogleMaps

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GMSServices.provideAPIKey("AIzaSyB36Rtl4Pab5g-hSgXZZICQZzLG7vxQgTw")
        return true
    }
}
