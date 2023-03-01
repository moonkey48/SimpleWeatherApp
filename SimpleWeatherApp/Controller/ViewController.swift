//
//  ViewController.swift
//  SimpleWeatherApp
//
//  Created by moonkey on 2023/02/28.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    var backgroundImageView: UIImageView?
    
    let weatherManager = WeatherManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupConfigureUI()
        assignbackground()
    }
    func assignbackground(){
        
        let image = UIImage(named: "Sunny")
        backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView?.contentMode =  UIView.ContentMode.scaleAspectFill
        backgroundImageView?.clipsToBounds = true
        backgroundImageView?.image = image
        backgroundImageView?.center = view.center
        view.addSubview(backgroundImageView!)
        self.view.sendSubviewToBack(backgroundImageView!)
        
    }
    func setupConfigureUI(){
        countryLabel.text = "KR"
        regionLabel.text = "Seoul"
        currentTempLabel.text = "0\(WeatherAPI.celcius)"
        currentWeatherLabel.text = "Sunny"
        minTempLabel.text = "0\(WeatherAPI.celcius)"
        maxTempLabel.text = "0\(WeatherAPI.celcius)"
    }
    func setupData(){
        weatherManager.getWeatherInfo { result in
            switch result {
            case .success(let weatherData):
                DispatchQueue.main.async { [weak self] in
                    self?.countryLabel.text = "\(weatherData.sys.country)"
                    self?.regionLabel.text = "\(weatherData.name)"
                    let currentTemp = round((weatherData.main.temp) - 273.15)
                    let minTemp = round((weatherData.main.tempMin) - 273.15)
                    let maxTemp = round((weatherData.main.tempMax) - 273.15)
                    self?.currentTempLabel.text = "\(Int(currentTemp))\(WeatherAPI.celcius)"
                    self?.currentWeatherLabel.text = "\(weatherData.weather[0].main)"
                    self?.minTempLabel.text = "\(Int(minTemp))\(WeatherAPI.celcius)"
                    self?.maxTempLabel.text = "\(Int(maxTemp))\(WeatherAPI.celcius)"
                    self?.backgroundImageView?.image = UIImage(named: weatherData.weather[0].main)
                }
                print("get weather data")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

