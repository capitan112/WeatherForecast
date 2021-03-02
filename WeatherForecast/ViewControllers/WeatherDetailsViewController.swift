//
//  WeatherDetailsViewController.swift
//  WeatherForecast
//
//  Created by Oleksiy Chebotarov on 28/02/2021.
//

import UIKit

final class WeatherDetailsViewController: UIViewController, Storyboarded {
    @IBOutlet var containerView: UIView!
    @IBOutlet var weatherImageView: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var weatherDescriptionLabel: UILabel!
    @IBOutlet var feelLikeContainerView: UIView!
    @IBOutlet var feelLikeLabel: UILabel!
    @IBOutlet var maxTemperatureLabel: UILabel!
    @IBOutlet var minTemperatureLabel: UILabel!
    var viewModel: WeatherDetailsViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupProperties()
        addBackgroundGradient()
        configNavigationBar()
    }

    private func configNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backArrow")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backArrow")
    }

    private func configUI() {
        containerView.layer.cornerRadius = 7
        containerView.layer.borderWidth = 1.5
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.backgroundColor = .clear
        feelLikeContainerView.layer.cornerRadius = 15
        feelLikeContainerView.backgroundColor = UIColor(red: 0.01, green: 0.36, blue: 0.78, alpha: 1.00)
        feelLikeLabel.addCharacterSpacing(kernValue: 0.29)
        weatherImageView.tintColor = .white
        navigationController?.navigationBar.backgroundColor = .clear
    }

    private func addBackgroundGradient() {
        var startColor = UIColor(red: 0.23, green: 0.45, blue: 0.96, alpha: 1.00)
        var endColor = UIColor(red: 0.35, green: 0.58, blue: 0.73, alpha: 1.00)

        if let viewModel = viewModel {
            startColor = viewModel.weatherDetails.startColor
            endColor = viewModel.weatherDetails.endColor
        }

        view.addGradientBackground(startColor: startColor, endColor: endColor)
    }

    private func setupProperties() {
        guard let viewModel = viewModel else { return }
        let details = viewModel.weatherDetails
        temperatureLabel.text = details.temperature
        cityNameLabel.text = details.cityName
        weatherDescriptionLabel.text = details.weatherDescription
        feelLikeLabel.text = details.feelLike
        maxTemperatureLabel.text = details.maxTemperature
        minTemperatureLabel.text = details.minTemperature

        performUIUpdatesOnMain {
            self.weatherImageView.loadImage(icon: details.weatherIcon)
        }
    }
}
