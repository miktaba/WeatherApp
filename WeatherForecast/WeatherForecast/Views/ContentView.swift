//
//  ContentView.swift
//  WeatherForecast
//
//  Created by Mikhail Tabakaev on 9/23/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    @State var isNight = false
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        ZStack {
            isNight ? BackgroundViewTest(isNight: true): BackgroundViewTest(isNight: false)
            
            VStack{
                if let location = locationManager.location {
                    if let weather = weather {
                        WeatherView(weather: weather)
                    } else {
                        LoadingView()
                            .task {
                                do {
                                    weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                } catch {
                                    print("Error getting weather: \(error)")
                                }
                            }
                    }
                } else {
                    if locationManager.isLoading {
                        LoadingView()
                    } else {
                        WelcomeView()
                            .environmentObject(locationManager)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

