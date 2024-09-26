//
//  MainTabView.swift
//  WeatherForecast
//
//  Created by Mikhail Tabakaev on 9/26/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            WelcomeView()
                .tabItem {
                    Label("Location", systemImage: "location.fill")
                }
        }
    }
}

#Preview {
    MainTabView()
}
