//
//  WelcomeView.swift
//  WeatherForecast
//
//  Created by Mikhail Tabakaev on 9/25/24.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        
        ZStack {
            VStack {
                VStack(spacing: 20) {
                    Text("Welcome to the weather app")
                        .bold().font(.title)
                    Text("Please share your location to get the forecast in your area")
                        .padding()
                }
                .multilineTextAlignment(.center)
                .padding()
                
                LocationButton(.shareCurrentLocation) {
                    locationManager.requestLocation()
                }
                .cornerRadius(10)
                .symbolVariant(.fill)
                .foregroundColor(.white)
            }
        
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    
    }
}

#Preview {
    WelcomeView()
}
