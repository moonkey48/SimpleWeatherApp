//
//  WeatherData.swift
//  SimpleWeatherApp
//
//  Created by moonkey on 2023/02/28.
//

import Foundation


// MARK: - Welcome
struct WeatherData: Codable {
    let weather: [Weather]
    let main: Main
    let sys: Sys
    let name: String
}


// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}
