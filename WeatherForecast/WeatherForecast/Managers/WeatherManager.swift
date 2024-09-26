//
//  WeatherManager.swift
//  WeatherForecast
//
//  Created by Mikhail Tabakaev on 9/25/24.
//

import Foundation
import SwiftUI
import CoreLocation

class WeatherManager: ObservableObject {
    
    let decoder = JSONDecoder()
    
    let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    let apiKey = "6fb524e2aac61704638d2a7ccf3afba7"
    
    @Published var weather: ResponseBody?
    @Published var isLoading = false
    @Published var error: String?
    
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        let endpoint = "\(baseURL)?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        print(endpoint)
        
        guard let url = URL(string: endpoint) else {
            isLoading = false
            throw WAErorr.invalidURL
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw WAErorr.invalidResponse
        }
        do {
            return try decoder.decode(ResponseBody.self, from: data)
        } catch {
            throw WAErorr.invalidData
        }
    }
}


func getWeatherIcon(for main: String) -> Image {
    switch main {
    case "Clear":
        return SFSymbols.clear
    case "Clouds":
        return SFSymbols.cloudy
    case "Rain":
        return SFSymbols.rainy
    case "Snow":
        return SFSymbols.snow
    case "Thunderstorm":
        return SFSymbols.thunder
    default:
        return SFSymbols.placrholder
    }
}


struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse

    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}

extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}
