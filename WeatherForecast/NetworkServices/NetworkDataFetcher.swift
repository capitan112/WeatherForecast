//
//  NetworkDataFetcher.swift
//  WeatherForecast
//
//  Created by Oleksiy Chebotarov on 27/02/2021.
//

import Foundation

enum ConversionFailure: Error {
    case invalidData
    case missingData
    case responceError
}

protocol NetworkDataFetcherProtocol {
    func fetchWeather(by ulr: String, completion: @escaping (Result<WeatherInfo, Error>) -> Void)
    func fetchGenericJSONData(urlString: String, response: @escaping (Result<WeatherInfo, Error>) -> Void)
}

final class NetworkDataFetcher: NetworkDataFetcherProtocol {
    var networking: NetworkProtocol
    private let imageCache = NSCache<AnyObject, AnyObject>()

    init(networking: NetworkProtocol = NetworkService()) {
        self.networking = networking
    }

    func loadImage(icon: String, completion: @escaping (Result<Data, Error>) -> Void) {
        networking.request(icon: icon, completion: completion)
    }

    func fetchWeather(by ulr: String, completion: @escaping (Result<WeatherInfo, Error>) -> Void) {
        fetchGenericJSONData(urlString: ulr, response: completion)
    }

    func fetchGenericJSONData(urlString: String, response: @escaping (Result<WeatherInfo, Error>) -> Void) {
        networking.request(urlString: urlString) { dataResponse in
            guard let data = try? dataResponse.get() else {
                response(.failure(ConversionFailure.responceError))
                return
            }

            self.decodeJSON(from: data, completion: response)
        }
    }

    private func decodeJSON(from data: Data?, completion: @escaping (Result<WeatherInfo, Error>) -> Void) {
        guard let data = data else {
            completion(.failure(ConversionFailure.missingData))
            return
        }

        let decoder = JSONDecoder()
        do {
            let result = Result(catching: {
                try decoder.decode(WeatherInfo.self, from: data)
            })

            completion(result)
        }
    }
}
