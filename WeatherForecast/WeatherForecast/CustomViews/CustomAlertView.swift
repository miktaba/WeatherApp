//
//  CustomAlertView.swift
//  WeatherForecast
//
//  Created by Mikhail Tabakaev on 10/3/24.
//

import SwiftUI

struct CustomAlertView: View {
    var title: String
    var message: String
    var dismissAction: () -> Void
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.bottom, 5)
            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button(action: dismissAction) {
                Text("Dismiss")
                    .frame(width: 200, height: 10)
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .frame(width: 300, height: 200)
        .background(Color.white.opacity(0.8))
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
    }
}

#Preview {
    CustomAlertView(title: "Hmm...", message: "Something went wrong...", dismissAction: {})
}
