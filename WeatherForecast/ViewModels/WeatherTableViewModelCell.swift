//
//  WeatherTableViewCell.swift
//  WeatherForecast
//
//  Created by Oleksiy Chebotarov on 27/02/2021.
//

import Foundation
import UIKit

final class WeatherTableViewModelCell: WeatherTableViewModelCellType {
    private var weatherParameters: WeatherParameters
    var temperature: String {
        return format(temperature: weatherParameters.temperature) + "c"
    }

    var cityName: String {
        return weatherParameters.name
    }

    var weatherIcon: String? {
        return weatherParameters.weatherIcon
    }

    var startColor: UIColor {
        return UIColor.color(by: weatherParameters.weatherIcon ?? "01d").0
    }

    var endColor: UIColor {
        return UIColor.color(by: weatherParameters.weatherIcon ?? "01d").1
    }

    init(weatherParameters: WeatherParameters) {
        self.weatherParameters = weatherParameters
    }

    private func format(temperature: Double) -> String {
        let formatter = NumberFormatter()
        return formatter.format(temperature: temperature)
    }
}
