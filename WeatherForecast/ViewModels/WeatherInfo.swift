//
//  Weather.swift
//  WeatherForecast
//
//  Created by Oleksiy Chebotarov on 27/02/2021.
//

import Foundation

import Foundation

struct WeatherInfo: Decodable {
    let weatherParameters: [WeatherParameters]

    private enum CodingKeys: String, CodingKey {
        case weatherParameters = "list"
    }
}

struct WeatherParameters: Decodable {
    let name: String
    var description: String?
    var weatherIcon: String?
    let temperature: Double
    let feelsLike: Double
    let temperatureMin: Double
    let temperatureMax: Double

    enum CodingKeys: String, CodingKey {
        case name, weather, description, main
        case weatherIcon = "icon"
        case temperature = "temp"
        case feelsLike = "feels_like"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        var weatherArray = try container.nestedUnkeyedContainer(forKey: .weather)

        while !weatherArray.isAtEnd {
            let dict = try weatherArray.nestedContainer(keyedBy: CodingKeys.self)
            description = try dict.decode(String.self, forKey: .description)
            weatherIcon = try dict.decode(String.self, forKey: .weatherIcon)
        }

        let mainDict = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .main)
        temperature = try mainDict.decode(Double.self, forKey: .temperature)
        feelsLike = try mainDict.decode(Double.self, forKey: .feelsLike)
        temperatureMin = try mainDict.decode(Double.self, forKey: .temperatureMin)
        temperatureMax = try mainDict.decode(Double.self, forKey: .temperatureMax)
    }
}
