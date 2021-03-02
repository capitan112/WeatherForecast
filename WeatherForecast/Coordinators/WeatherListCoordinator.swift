//
//  WeatherListCoordinator.swift
//  WeatherForecast
//
//  Created by Oleksiy Chebotarov on 27/02/2021.
//

import Foundation
import UIKit

protocol WeatherDetailsFlow: class {
    func coordinateToWeatherDetails(with details: WeatherParameters)
}

final class WeatherListCoordinator: Coordinator, WeatherDetailsFlow {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let weatherTableViewController = WeatherTableViewController.instantiate(storyboardName: "Main")
        weatherTableViewController.coordinator = self
        let weatherViewModel = WeatherViewModel()
        weatherViewModel.fetchWeather()
        weatherTableViewController.viewModel = weatherViewModel
        navigationController.pushViewController(weatherTableViewController, animated: true)
    }

    func coordinateToWeatherDetails(with details: WeatherParameters) {
        let weatherDetailsCoordinator = WeatherDetailsCoordinator(navigationController: navigationController, details: details)
        coordinate(to: weatherDetailsCoordinator)
    }
}
