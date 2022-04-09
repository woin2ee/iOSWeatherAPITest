//
//  WeatherInfo.swift
//  WeatherAPITest
//
//  Created by Jaewon on 2022/04/09.
//

import Foundation

struct WeatherInfo: Codable {
    let weather: [Weather]
    let name: String
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
