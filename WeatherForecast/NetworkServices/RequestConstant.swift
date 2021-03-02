//
//  RequestConstant.swift
//  WeatherForecast
//
//  Created by Oleksiy Chebotarov on 27/02/2021.
//

import Foundation

struct RequestConstant {
    // MARK: Server

    enum Server {
        static let APIScheme = "http"
        static let APIHost = "api.openweathermap.org"
        static let APIHostImage = "openweathermap.org"
        static let APIPath = "/data/2.5/group"
        static let APIKey = "de44747154010728e51a84882ca43698"
        static let APIUnits = "metric"
        static let APIImage = "/img/wn/"
    }
}
