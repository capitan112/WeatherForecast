//
//  WeatherTableViewController.swift
//  WeatherForecast
//
//  Created by Oleksiy Chebotarov on 27/02/2021.
//

import UIKit

final class WeatherTableViewController: UIViewController, Storyboarded {
    @IBOutlet var tableView: UITableView!

    private var weatherParameters: [WeatherParameters]?
    var coordinator: WeatherDetailsFlow?
    var viewModel: WeatherViewModelType? {
        didSet {
            setupBindings()
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        configTableView()
        addBackgroundGradient()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBarTitle()
    }

        
    private func addBackgroundGradient() {
        let startColor = UIColor(red: 0.02, green: 0.03, blue: 0.24, alpha: 1.00)
        let endColor = UIColor(red: 0.50, green: 0.31, blue: 0.67, alpha: 1.00)
        view.addGradientBackground(startColor: startColor, endColor: endColor)
    }

    private func configNavigationBarTitle() {
        title = "Cities Weather"
    }
    
    private func configNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

    private func setupBindings() {
        viewModel?.weatherParameters.bind { weatherParameters in
            if let weatherParameters = weatherParameters {
                self.weatherParameters = weatherParameters
                self.reloadTableView()
            }
        }
    }

    private func reloadTableView() {
        performUIUpdatesOnMain { [unowned self] in
            self.tableView.reloadData()
        }
    }

    private func configTableView() {
        let className = String(describing: WeatherTableViewCell.self)
        tableView.register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: WeatherTableViewCell.reuseIdentifier)
        tableView.rowHeight = 87.0
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }
}

extension WeatherTableViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return weatherParameters?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = WeatherTableViewCell.reuseIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! WeatherTableViewCell

        if let weatherParameters = weatherParameters {
            let weatherViewModelCell = WeatherTableViewModelCell(weatherParameters: weatherParameters[indexPath.row])
            cell.viewModel = weatherViewModelCell
        }
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let weatherDetails = weatherParameters?[indexPath.row] else {
            return
        }
        coordinator?.coordinateToWeatherDetails(with: weatherDetails)
    }
}
