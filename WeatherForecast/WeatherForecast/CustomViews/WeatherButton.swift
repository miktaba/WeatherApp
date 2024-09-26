//
//  WeatherButton.swift
//  WeatherForecast
//
//  Created by Mikhail Tabakaev on 9/24/24.
//

import SwiftUI

struct WeatherButton: View {
    
    var title: String
    var textColor: Color
    var backgroundColor: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(width: 280, height: 50)
                .background(backgroundColor)
                .foregroundStyle(textColor)
                .font(.system(size: 20, weight: .bold, design: .default))
                .cornerRadius(10)
        }
    }
}
