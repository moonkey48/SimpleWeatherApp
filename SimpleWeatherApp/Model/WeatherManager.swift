//
//  WeatherManager.swift
//  SimpleWeatherApp
//
//  Created by moonkey on 2023/02/28.
//

import Foundation

enum NetworkError: Error {
    case networkError
    case dataError
    case parseError
}

final class WeatherManager {
    
    
    static let shared = WeatherManager()
    
    private init() {}
    
    typealias NetworkCompletion = (Result<WeatherData, NetworkError>) -> Void
    
    func getWeatherInfo(completion: @escaping NetworkCompletion){
        let urlString = "\(WeatherAPI.requestURL)\(WeatherAPI.params)&appid=\(SecretKey.apiKey)"
        performRequest(urlString: urlString,completion: completion)
    }
    private func performRequest(urlString: String, completion: @escaping NetworkCompletion){
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, res, error) in
            if error != nil {
                print(error!)
                completion(.failure(.networkError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            if let weatherData = self.parseJSON(safeData) {
                print("parse success")
                completion(.success(weatherData))
            } else {
                print("parse fail")
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
    
    private func parseJSON(_ weatherData: Data) -> WeatherData? {
        do {
            let weatherData = try JSONDecoder().decode(WeatherData.self, from: weatherData)
            return weatherData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
