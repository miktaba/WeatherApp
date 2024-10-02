//
//  ContentView.swift
//  WeatherForecast
//
//  Created by Mikhail Tabakaev on 9/23/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var weather: ResponseBody?
    @State var placePhoto: UnsplashPhoto?
    
    var body: some View {
        ZStack {
            if colorScheme == .dark {
                MeshGradientBackground(isNight: true)
            } else {
                MeshGradientBackground(isNight: false)
            }
            
            VStack{
                if let location = locationManager.location {
                    if let weather = weather, let placePhoto = placePhoto {
                        WeatherView(weather: weather, placePhoto: placePhoto)
                    } else {
                        LoadingView()
                            .task {
                                do {
                                    weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                    
                                    if let placeName = weather?.name {
                                        let imageManager = ImageManager()
                                        placePhoto = try await imageManager.fetchPhotos(for: placeName)
                                    }
                                    
                                } catch {
                                    print("Error getting weather or photo.")
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

