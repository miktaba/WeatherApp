//
//  LocationManager.swift
//  WeatherForecast
//
//  Created by Mikhail Tabakaev on 9/25/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false
    
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    private func requestWhenInUseAuthorization() {
            manager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Errror getting location: \(error.localizedDescription)")
        isLoading = false
    }
}
