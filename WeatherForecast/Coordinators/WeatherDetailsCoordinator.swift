//
//  WeatherDetailsCoordinator.swift
//  WeatherForecast
//
//  Created by Oleksiy Chebotarov on 28/02/2021.
//

import Foundation
import UIKit

final class WeatherDetailsCoordinator: Coordinator {
    let navigationController: UINavigationController
    var weatherParameters: WeatherParameters

    init(navigationController: UINavigationController, details: WeatherParameters) {
        self.navigationController = navigationController
        weatherParameters = details
    }

    func start() {
        let weatherDetailsViewController = WeatherDetailsViewController.instantiate(storyboardName: "Main")
        let weatherDetailsViewModel = WeatherDetailsViewModel(weatherParameters: weatherParameters)
        weatherDetailsViewController.viewModel = weatherDetailsViewModel
        navigationController.pushViewController(weatherDetailsViewController, animated: true)
    }
}
