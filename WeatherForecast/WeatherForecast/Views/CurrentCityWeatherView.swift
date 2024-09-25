//
//  CurrentCityWeatherView.swift
//  WeatherForecast
//
//  Created by Mikhail Tabakaev on 9/25/24.
//

import SwiftUI

struct CurrentCityWeatherView: View {
        @StateObject var locationManager = LocationManager()
        
        
        let weatherData = [
            ("Mon", "cloud.sun.fill", 21),
            ("Tue", "sun.max.fill", 25),
            ("Wed", "wind", 19),
            ("Thu", "cloud.sun.rain.fill", 22),
            ("Fri", "cloud.sun.fill", 24)
        ]
        
        @State var isNight = true
        
        var body: some View {
            ZStack {
                if isNight {
                    BackgroundView(isNight: true)
                } else {
                    BackgroundView(isNight: false)
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
    CurrentCityWeatherView()
}





struct BackgroundView: View {
    
    @State var isAnimating = false
    var isNight: Bool
    
    
    var body: some View {
        if #available(iOS 18, *) {
            MeshGradient(
                width: isNight ? 5 : 3,
                height: isNight ? 5 : 3,
                points: isNight ? darkGradientPoints() : lightGradientPoints(),
                colors: isNight ? darkGradientColors() : lightGradientColors(),
                smoothsColors: true,
                colorSpace: .perceptual
            )
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                withAnimation(.easeOut(duration: 5).repeatForever(autoreverses: true)) {
                    isAnimating.toggle()
                }
            }
        } else {
            fallbackView
        }
    }
    
    var fallbackView: some View {
        LinearGradient(
            gradient: Gradient(
                colors: isNight ? [.black, .gray, .white] : [.blue, .green, Color("lightBlue")]
            ),
            startPoint: .topTrailing,
            endPoint: .bottomLeading
        )
        .edgesIgnoringSafeArea(.all)
    }
    
    
    private func lightGradientPoints() -> [SIMD2<Float>] {
        return [
            SIMD2(0.0, 0.0), SIMD2(0.5, 0.0), SIMD2(1.0, 0.0),
            SIMD2(0.0, 0.5), SIMD2(0.5, 0.5), SIMD2(1.0, 0.5),
            SIMD2(0.0, 1.0), SIMD2(0.5, 1.0), SIMD2(1.0, 1.0)
        ]
    }
    
    
    private func lightGradientColors() -> [Color] {
        return [
            .teal, .mint, isAnimating ? .green : .teal,
            .blue, isAnimating ? .blue : .green, .blue,
            isAnimating ? .green : .teal, .mint, .teal
        ]
    }
    
    
    private func darkGradientPoints() -> [SIMD2<Float>] {
        return [
            SIMD2(0.0, 0.0), SIMD2(0.25, 0.0), SIMD2(0.5, 0.0), SIMD2(0.75, 0.0), SIMD2(1.0, 0.0),
            SIMD2(0.0, 0.25), SIMD2(0.25, 0.25), SIMD2(0.5, 0.25), SIMD2(0.75, 0.25), SIMD2(1.0, 0.25),
            SIMD2(0.0, 0.5), SIMD2(0.25, 0.5), SIMD2(0.5, 0.5), SIMD2(0.75, 0.5), SIMD2(1.0, 0.5),
            SIMD2(0.0, 0.75), SIMD2(0.25, 0.75), SIMD2(0.5, 0.75), SIMD2(0.75, 0.75), SIMD2(1.0, 0.75),
            SIMD2(0.0, 1.0), SIMD2(0.25, 1.0), SIMD2(0.5, 1.0), SIMD2(0.75, 1.0), SIMD2(1.0, 1.0)
        ]
    }
    
    
    private func darkGradientColors() -> [Color] {
        return [
            isAnimating ? .black : .gray, isAnimating ? .black : .gray, isAnimating ? .black : .gray,
            isAnimating ? .black : .gray, isAnimating ? .black : .gray,
            .gray, isAnimating ? .black : .gray, isAnimating ? .black : .gray, isAnimating ? .black : .gray, .gray,
            .gray, .gray, .gray, .gray, .gray,
            .gray, .gray, .gray, .gray, .gray,
            .gray, .gray, .gray, .gray, .gray
        ]
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


