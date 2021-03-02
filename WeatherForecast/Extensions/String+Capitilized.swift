//
//  String+Capitilized.swift
//  WeatherForecast
//
//  Created by Oleksiy Chebotarov on 28/02/2021.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = capitalizingFirstLetter()
    }
}
