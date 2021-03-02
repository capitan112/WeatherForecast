//
//  NumberFormatter+Round.swift
//  WeatherForecast
//
//  Created by Oleksiy Chebotarov on 28/02/2021.
//

import Foundation

extension NumberFormatter {
    static func format(temperature: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
        formatter.maximumFractionDigits = 0

        return formatter.string(from: NSNumber(value: temperature)) ?? ""
    }
}
