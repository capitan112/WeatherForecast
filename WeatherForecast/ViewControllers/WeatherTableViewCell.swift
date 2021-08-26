//
//  WeatherTableViewCell.swift
//  WeatherForecast
//
//  Created by Oleksiy Chebotarov on 27/02/2021.
//

import UIKit

protocol WeatherTableViewModelCellType {
    var temperature: String { get }
    var cityName: String { get }
    var weatherIcon: String? { get }
    var startColor: UIColor { get }
    var endColor: UIColor { get }
}

final class WeatherTableViewCell: UITableViewCell {
    static var reuseIdentifier: String = "CellID"
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var weatherImageView: UIImageView!

    var viewModel: WeatherTableViewModelCellType? {
        didSet {
            updateUI()
            addBackgroundGradient()
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        weatherImageView.image = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20))
    }

    private func configUI() {
        weatherImageView.tintColor = .white
        contentView.layer.cornerRadius = 7
        contentView.layer.masksToBounds = true
        temperatureLabel.backgroundColor = .clear
        selectionStyle = .none
    }

    private func addBackgroundGradient() {
        guard let viewModel = viewModel else { return }
        contentView.addGradientBackground(startColor: viewModel.startColor,
                                          endColor: viewModel.endColor,
                                          startPoint: CGPoint(x: 0, y: 0),
                                          endPoint: CGPoint(x: 1, y: 1))

    }

    private func updateUI() {
        guard let viewModel = viewModel else { return }
        cityNameLabel.text = viewModel.cityName
        temperatureLabel.text = viewModel.temperature

        if let icon = viewModel.weatherIcon {
            performUIUpdatesOnMain {
                self.weatherImageView.loadImage(icon: icon)
            }
        }
    }
}
