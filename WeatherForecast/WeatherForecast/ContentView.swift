//
//  ContentView.swift
//  WeatherForecast
//
//  Created by Mikhail Tabakaev on 9/23/24.
//

import SwiftUI

struct ContentView: View {
    
    let weatherData = [
            ("Mon", "cloud.sun.fill", 21),
            ("Tue", "sun.max.fill", 25),
            ("Wed", "wind", 19),
            ("Thu", "cloud.sun.rain.fill", 22),
            ("Fri", "cloud.sun.fill", 24)
        ]
    
    @State private var isNight = true
    
    var body: some View {
        ZStack {
            
            if isNight {
                DarkBackgroundView()
            } else {
                LightBackgroundView()
            }
            
            VStack {
                CityTextView(cityName: "Bar, Montenegro")
                
                MainWeatherStatusView(
                    imageName: isNight ? "moon.zzz.fill" : "cloud.sun.fill",
                    temperature: 25
                )
                
                .padding(.bottom, 40)
                    
                    HStack(spacing: 20) {
                        ForEach(weatherData, id: \.0) { data in
                            WeatherDayView(
                                dayOfWeek: data.0,
                                imageName: data.1,
                                temperature: data.2
                            )
                        }
                    }
                
                Spacer()
                
                Button {
                    isNight.toggle()
                } label: {
                    WeatherButton(title: "Change Day Time", textColor: .blue, backgroundColor: .white)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}





struct LightBackgroundView: View {
    
    @State var isAnimating = false
    
    var body: some View {
        if #available(iOS 18, *) {
            MeshGradient(width: 3, height: 3, points: [
                [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
                [0.0, 1.0], [0.5, 1], [1.0, 1.0]
            ], colors: [
                .teal, .mint, isAnimating ? .green: .teal,
                .blue, isAnimating ? .blue : .green, .blue,
                isAnimating ? .green: .teal, .mint, .teal
            ], smoothsColors: true, colorSpace: .perceptual
            )
            
            .edgesIgnoringSafeArea(.all)
            
            .onAppear() {
                withAnimation(.easeOut(duration: 5).repeatForever(autoreverses: true)) { isAnimating.toggle()
                }
            }
        } else {
            Color(.blue)
            LinearGradient(
                gradient: Gradient(
                    colors: [.blue, .green, Color("lightBlue")]
                ),
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
            
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct DarkBackgroundView: View {
    
    @State var isAnimating = false
    
    var body: some View {
        if #available(iOS 18, *) {
            MeshGradient(width: 5, height: 5, points: [
                [0.0, 0.0], [0.25, 0.0], [0.5, 0.0], [0.75, 0.0] ,[1.0, 0.0],
                [0.0, 0.25], [0.25, 0.25], [0.5, 0.25], [0.75, 0.25] ,[1.0, 0.25],
                [0.0, 0.5], [0.25, 0.5], [0.5, 0.5], [0.75, 0.5] ,[1.0, 0.5],
                [0.0, 0.75], [0.25, 0.75], [0.5, 0.75], [0.75, 0.75] ,[1.0, 0.75],
                [0.0, 1.0], [0.25, 1.0], [0.5, 1.0], [0.75, 1.0] ,[1.0, 1.0],
                
            ], colors: [
                isAnimating ? .black : .gray, isAnimating ? .black : .gray, isAnimating ? .black : .gray, isAnimating ? .black: .gray, isAnimating ? .black : .gray,
                .gray, isAnimating ? .black : .gray, isAnimating ? .black : .gray, isAnimating ? .black: .gray, .gray,
                .gray, .gray, .gray, .gray, .gray,
                .gray, .gray, .gray, .gray, .gray,
                .gray, .gray, .gray, .gray, .gray,
            ], smoothsColors: true, colorSpace: .perceptual
            )
            
            .edgesIgnoringSafeArea(.all)
            
            .onAppear() {
                withAnimation(.easeOut(duration: 5).repeatForever(autoreverses: true)) { isAnimating.toggle()
                }
            }
        } else {
            Color(.blue)
            LinearGradient(
                gradient: Gradient(
                    colors: [.black, .gray, .white]
                ),
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
            
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct CityTextView: View {
    
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 30, weight: .medium, design: .default))
            .foregroundStyle(.white)
            .padding()
    }
}

struct MainWeatherStatusView: View {
    
    var imageName: String
    var temperature: Int
    
    var body: some View {
            VStack(spacing: 10) {
                Image(systemName: imageName)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180)
                
                Text("\(temperature)°")
                    .font(.system(size: 70, weight: .medium))
                    .foregroundStyle(.white)
                    .padding()
            }
        }
    }


