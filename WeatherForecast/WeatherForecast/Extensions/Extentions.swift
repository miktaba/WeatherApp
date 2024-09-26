//
//  Extentions.swift
//  WeatherForecast
//
//  Created by Mikhail Tabakaev on 9/26/24.
//

import Foundation
import SwiftUI

extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(corners: corners, radius: radius))
    }
}


struct RoundedCorner: Shape {
    var corners: UIRectCorner = .allCorners
    var radius: CGFloat = .infinity

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
