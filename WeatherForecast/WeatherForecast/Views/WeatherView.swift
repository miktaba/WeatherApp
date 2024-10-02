//
//  WeatherView.swift
//  WeatherForecast
//
//  Created by Mikhail Tabakaev on 9/25/24.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject var locationManager: LocationManager
    @StateObject var weatherManager = WeatherManager()
    @StateObject var imageManager = ImageManager()
    
    @Environment(\.colorScheme) var colorScheme
    
    var weather: ResponseBody
    var placePhoto: UnsplashPhoto
    
    var body: some View {
        ZStack {
            if colorScheme == .dark {
                MeshGradientBackground(isNight: true)
            } else {
                MeshGradientBackground(isNight: false)
            }
            ZStack(alignment: .leading) {
                VStack (alignment: .leading) {
                    VStack(alignment: .leading) {
                        VStack{
                            getWeatherIcon(for: weather.weather[0].main)
                            //Image(systemName: "cloud")
                                .font(.system(size: 50))
                            Text(weather.weather[0].main)
                                .font(.system(size: 20))
                        }
                        .padding(.leading)
                        
                        HStack {
                            Text(weather.main.feelsLike.roundDouble() + "°")
                                .font(.system(size: 70))
                                .fontWeight(.bold)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(weather.name)
                                    .bold().font(.title)
                                
                                Text("Today, \(Date().formatted(.dateTime.day().month().hour()))")
                                    .fontWeight(.light)
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        
                        
                        
                    }
                    
                    VStack {
                        if let photo = imageManager.photo {
                            AsyncImage(url: URL(string: photo.urls.regular)) { image in image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 350, height: 250)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .overlay(RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white, lineWidth: 2)
                                    )
                            } placeholder: {ProgressView()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            }
                            .frame(width: 350, height: 250)
                            
                        } else {
                            Image(.placeholder)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 350, height: 250)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay(RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 2)
                                )
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                    
                        .onAppear{
                            Task {
                                do {
                                    let photo = try await  imageManager.fetchPhotos(for: weather.name)
                                    DispatchQueue.main.async {
                                        imageManager.photo = photo
                                    }
                                } catch {
                                    print("Error fetching photo.")
                                }
                            }
                        }
                    
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    Text("Details on today's weather")
                        .bold().padding(.bottom)
                    HStack {
                        VStack(alignment: .leading) {
                            WeatherRow(logoWeather: "thermometer.high", name: "Max temp", tempValue: weather.main.tempMax.roundDouble() + "°")
                            
                            WeatherRow(logoWeather: "thermometer.low", name: "Min temp", tempValue: weather.main.tempMin.roundDouble() + "°")
                        }
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            WeatherRow(logoWeather: "wind", name: "Wind speed", tempValue: weather.wind.speed.roundDouble() + "m/s")
                            
                            WeatherRow(logoWeather: "humidity.fill", name: "Humidity", tempValue: weather.main.humidity.roundDouble() + "%")
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundStyle(Color(hue: 0.568, saturation: 0.783, brightness: 0.912))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
            
        }
        .ignoresSafeArea(edges: .bottom)
        .preferredColorScheme(.dark)
    }
}


#Preview {
    WeatherView(weather: previewWeather, placePhoto: previewPhoto)
}
