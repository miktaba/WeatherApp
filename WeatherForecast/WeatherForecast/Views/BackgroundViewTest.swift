//
//  BackgroundViewTest.swift
//  WeatherForecast
//
//  Created by Mikhail Tabakaev on 9/25/24.
//

import SwiftUI

struct BackgroundViewTest: View {
    
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

#Preview {
    BackgroundViewTest(isNight: false)
}
