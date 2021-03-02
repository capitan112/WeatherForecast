//
//  MockWeatherViewModel.swift
//  WeatherForecastTests
//
//  Created by Oleksiy Chebotarov on 01/03/2021.
//

import Foundation
@testable import WeatherForecast

class MockWeatherViewModel: WeatherViewModelType {
    var weatherParameters: Bindable<[WeatherParameters]?> = Bindable(nil)

    var isFetchWeatherCalled = false
    func fetchWeather() {
        isFetchWeatherCalled = true
    }
}
