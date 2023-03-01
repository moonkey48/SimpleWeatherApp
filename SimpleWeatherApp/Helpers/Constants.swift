//
//  Constants.swift
//  SimpleWeatherApp
//
//  Created by moonkey on 2023/02/28.
//

import Foundation

public struct WeatherAPI {
    static let requestURL = "https://api.openweathermap.org/data/2.5/weather?"
    static let params = "lat=37.5&lon=127"
    static let celcius = "°C"
    private init() {}
}
