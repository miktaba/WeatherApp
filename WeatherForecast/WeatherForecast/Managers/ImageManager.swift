//
//  ImageManager.swift
//  WeatherForecast
//
//  Created by Mikhail Tabakaev on 10/2/24.
//

import Foundation
import SwiftUI

class ImageManager: ObservableObject {
    @Published var photo: UnsplashPhoto? = nil
    let decoder = JSONDecoder()
    
    let rawURL = "https://api.unsplash.com/photos/random?query=Podgorica&client_id=AEH7Il-xq5sc9QCT6E70pXYsj4vEmRYTY3c67qzWfKc"
    
    private let baseURL = "https://api.unsplash.com/photos/random?query="
    private let accessKey = "AEH7Il-xq5sc9QCT6E70pXYsj4vEmRYTY3c67qzWfKc"
    
    
    func fetchPhotos(for city: String) async throws -> UnsplashPhoto {
        let endpoint = "\(baseURL)\(city)&orientation=landscape&client_id=\(accessKey)"
        print(endpoint)
        guard let url = URL(string: endpoint) else {
            throw WAError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw WAError.invalidResponse
        }
        
        do {
            return try decoder.decode(UnsplashPhoto.self, from: data)
        } catch {
            throw WAError.invalidData
        }
    }
}

struct UnsplashPhoto: Codable {
    let id: String
    let urls: URLs
}

struct URLs: Codable {
    let regular: String
}
