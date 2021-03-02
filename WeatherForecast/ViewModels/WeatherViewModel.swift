//
//  WeatherViewModel.swift
//  WeatherForecast
//
//  Created by Oleksiy Chebotarov on 27/02/2021.
//

import Foundation

protocol WeatherViewModelType {
    func fetchWeather()
    var weatherParameters: Bindable<[WeatherParameters]?> { get set }
}

final class WeatherViewModel: WeatherViewModelType {
    var weatherParameters: Bindable<[WeatherParameters]?> = Bindable(nil)
    private let dataFetcher = NetworkDataFetcher()
    private var citiesCodes = "2643743,1850147,5128581,2950158,2968815"

    func fetchWeather() {
        dataFetcher.fetchWeather(by: citiesCodes, completion: { response in
            guard let weatherInfo = try? response.get() else { return }
            self.weatherParameters.value = weatherInfo.weatherParameters
        })
    }
}
