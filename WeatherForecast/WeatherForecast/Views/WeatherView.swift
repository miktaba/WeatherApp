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
    
    var weather: ResponseBody
    
    
    var body: some View {
        ZStack {
            BackgroundViewTest(isNight: false)
            
            ZStack(alignment: .leading) {
                VStack (alignment: .leading) {
                    VStack(alignment: .leading) {
                        VStack{
                            // getWeatherIcon(for: weather.weather[0].main)
                            Image(systemName: "cloud")
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
                    Spacer()
                    
                    VStack {
                        Spacer()
                            .frame(height: 10)
                        
                        AsyncImage(url: URL(string: "https://www.globtourmontenegro.com/inc/img/cities/1456-montenegro_cities_podgorica3.jpg")) { image in image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 250)
                                .cornerRadius(10)
                        } placeholder: {
                            ProgressView()
                        }
                        .padding(.bottom)
                        
                       
                        
                        Spacer()
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            VStack {
                Spacer()
                
                WeatherButton(title: "Refresh", textColor: .black, backgroundColor: .white) {
                }
                .padding(.bottom, 10)
                
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
    WeatherView(weather: previewWeather)
}
