//
//  WeatherModel.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 11/11/2023.
//

import Foundation

struct WeatherModel: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
    
    var temperatureCelsius: Int {
        Int(temp - 273.15)
    }
}

struct Weather: Decodable {
    let description: String
    let icon: String
}
