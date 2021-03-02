//
//  WeatherDetailsViewModel.swift
//  WeatherForecast
//
//  Created by Oleksiy Chebotarov on 28/02/2021.
//

import Foundation
import UIKit

struct WeatherDetails {
    let temperature: String
    let cityName: String
    let weatherDescription: String
    let feelLike: String
    let maxTemperature: String
    let minTemperature: String
    let weatherIcon: String

    var startColor: UIColor {
        return UIColor.color(by: weatherIcon).1
    }

    var endColor: UIColor {
        return UIColor.color(by: weatherIcon).0
    }
}

protocol WeatherDetailsViewModelType {
    var weatherDetails: WeatherDetails { get }
}

final class WeatherDetailsViewModel: WeatherDetailsViewModelType {
    private var weatherParameters: WeatherParameters
    var weatherDetails: WeatherDetails {
        let temperature = format(temperature: weatherParameters.temperature) + "c"
        let weatherDescription = weatherParameters.description?.capitalizingFirstLetter() ?? ""
        let feelLike = "Feels like " + format(temperature: weatherParameters.feelsLike) + "c"
        let maxTemperature = "H " + format(temperature: weatherParameters.temperatureMax) + "c"
        let minTemperature = "L " + format(temperature: weatherParameters.temperatureMin) + "c"
        let weatherIcon = weatherParameters.weatherIcon ?? ""

        return WeatherDetails(temperature: temperature,
                              cityName: weatherParameters.name,
                              weatherDescription: weatherDescription,
                              feelLike: feelLike,
                              maxTemperature: maxTemperature,
                              minTemperature: minTemperature,
                              weatherIcon: weatherIcon)
    }

    init(weatherParameters: WeatherParameters) {
        self.weatherParameters = weatherParameters
    }

    private func format(temperature: Double) -> String {
        return NumberFormatter.format(temperature: temperature)
    }
}
