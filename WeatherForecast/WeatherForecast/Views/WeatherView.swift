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
    
    var weather: ResponseBody?
    var placePhoto: UnsplashPhoto?
    
    var body: some View {
        ZStack {
            VStack (alignment: .leading) {
                VStack(alignment: .leading) {
                    VStack{
                        getWeatherIcon(for: weather?.weather[0].main ?? "Clouds")
                            .font(.system(size: 50))
                        
                        Text(weather?.weather[0].main ?? "none")
                            .font(.system(size: 20))
                    }
                    .padding(.leading)
                    
                    HStack {
                        Text((weather?.main.feelsLike.roundDouble() ?? "none") + "°")
                            .font(.system(size: 70))
                            .fontWeight(.bold)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(weather?.name ?? "An unknown place")
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
                    if let placePhoto = placePhoto {
                        AsyncImage(url: URL(string: placePhoto.urls.regular)) { image in image
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
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    Text("Details on today's weather")
                        .bold().padding(.bottom)
                    HStack {
                        VStack(alignment: .leading) {
                            WeatherRow(logoWeather: "thermometer.high", name: "Max temp", tempValue: (weather?.main.tempMax.roundDouble() ?? "none") + "°")
                            
                            WeatherRow(logoWeather: "thermometer.low", name: "Min temp", tempValue: (weather?.main.tempMin.roundDouble() ?? "none") + "°")
                        }
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            WeatherRow(logoWeather: "wind", name: "Wind speed", tempValue: (weather?.wind.speed.roundDouble() ?? "none") + "m/s")
                            
                            WeatherRow(logoWeather: "humidity.fill", name: "Humidity", tempValue: (weather?.main.humidity.roundDouble() ?? "none") + "%")
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
            
            .ignoresSafeArea(edges: .bottom)
        }
        .background(
                MeshGradientBackground()
            )
    }
}


#Preview {
    WeatherView(weather: previewWeather, placePhoto: previewPhoto)
}
