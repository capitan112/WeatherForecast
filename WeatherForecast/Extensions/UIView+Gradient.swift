//
//  UIView+Gradient.swift
//  WeatherForecast
//
//  Created by Oleksiy Chebotarov on 28/02/2021.
//

import UIKit

extension UIView {
    func addGradientBackground(startColor: UIColor,
                               endColor: UIColor,
                               startPoint: CGPoint = CGPoint(x: 0, y: 0),
                               endPoint: CGPoint = CGPoint(x: 0, y: 1)) {
        clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.frame = bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
