//
//  WAError.swift
//  WeatherForecast
//
//  Created by Mikhail Tabakaev on 9/26/24.
//

import Foundation

enum WAErorr: String, Error {
    case invalidURL = "Missing URL."
    case invalidResponse = "Invalid response from server. Please try again."
    case invalidData = "The data recived from the server was invalid. Please try again."
}
