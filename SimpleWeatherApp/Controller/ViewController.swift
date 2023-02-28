//
//  ViewController.swift
//  SimpleWeatherApp
//
//  Created by moonkey on 2023/02/28.
//

import UIKit

class ViewController: UIViewController {

    let weatherManager = WeatherManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    func setupData(){
        weatherManager.getWeatherInfo { result in
            switch result {
            case .success(let wetherData):
                print(wetherData.weather[0].main)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

