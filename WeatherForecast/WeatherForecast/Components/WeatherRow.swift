//
//  WeatherRow.swift
//  WeatherForecast
//
//  Created by Mikhail Tabakaev on 9/26/24.
//

import SwiftUI

struct WeatherRow: View {
    var logoWeather: String
    var name: String
    var tempValue: String
    
    
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: logoWeather)
                .font(.system(size: 30))
                .frame(width: 20, height: 20)
                .padding()
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.888))
                .cornerRadius(50)
                
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.caption)
                
                Text(tempValue)
                    .bold()
                    .font(.title)
                    
            }
        }
    }
}

#Preview {
    WeatherRow(logoWeather: "thermometer.low", name: "Min temp", tempValue: "21°")
}
