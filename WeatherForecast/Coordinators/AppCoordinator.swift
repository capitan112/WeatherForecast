//
//  AppCoordinator.swift
//  WeatherForecast
//
//  Created by Oleksiy Chebotarov on 27/02/2021.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        let startCoordinator = WeatherListCoordinator(navigationController: navigationController)
        coordinate(to: startCoordinator)
    }
}
