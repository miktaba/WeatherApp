//
//  MeshGradientBackground.swift
//  WeatherForecast
//
//  Created by Mikhail Tabakaev on 10/1/24.
//

import SwiftUI

struct MeshGradientBackground: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State var isAnimating = false
    
    private var isNight: Bool {
        colorScheme == .dark
    }
    
    var body: some View {
        if #available(iOS 18, *) {
            MeshGradient(
                width: 3,
                height: 3,
                points: isNight ? darkGradientPoints() : lightGradientPoints(),
                colors: isNight ? darkGradientColors() : lightGradientColors(),
                smoothsColors: true,
                colorSpace: .perceptual
            )
            .edgesIgnoringSafeArea(.all)
            
        } else {
            fallbackView
        }
    }
    
    var fallbackView: some View {
        LinearGradient(
            gradient: Gradient(
                colors: isNight ? [.black, .gray, .white] : [.blue, .green, .white]
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
        return[
            SIMD2(0.0, 0.0), SIMD2(0.5, 0.0), SIMD2(1.0, 0.0),
            SIMD2(0.0, 0.5), SIMD2(0.5, 0.5), SIMD2(1.0, 0.5),
            SIMD2(0.0, 1.0), SIMD2(0.5, 1.0), SIMD2(1.0, 1.0)
        ]
    }
    
    
    private func darkGradientColors() -> [Color] {
        return [
            .lightBlue, .gray, isAnimating ? .lightBlue : .gray,
            .gray, isAnimating ? .lightBlue : .gray, .gray,
            .gray, .gray, isAnimating ? .lightBlue : .gray
        ]
    }
}

#Preview {
    MeshGradientBackground()
}
