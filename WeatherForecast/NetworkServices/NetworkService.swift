//
//  NetworkService.swift
//  WeatherForecast
//
//  Created by Oleksiy Chebotarov on 27/02/2021.
//

import Foundation

protocol NetworkProtocol {
    func request(urlString: String, completion: @escaping (Result<Data, Error>) -> Void)
    func request(icon: String, completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkService: NetworkProtocol {

    func request(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = urlFromParameters(cities: urlString)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }

    func request(icon: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = urlFromParameters(weatherIcon: icon)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }

    private func createDataTask(from request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in

            if error != nil || data == nil {
                completion(.failure(error!))
                return
            }

            guard let response = response as? HTTPURLResponse, (200 ... 299).contains(response.statusCode) else {
                completion(.failure(ConversionFailure.responceError))
                return
            }

            guard let data = data else {
                completion(.failure(ConversionFailure.invalidData))
                return
            }

            completion(.success(data))
        })
    }

    private func urlFromParameters(cities: String) -> URL {
        var components = URLComponents()
        components.scheme = RequestConstant.Server.APIScheme
        components.host = RequestConstant.Server.APIHost
        components.path = RequestConstant.Server.APIPath
        components.queryItems = [
            URLQueryItem(name: "id", value: "\(cities)"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: "\(RequestConstant.Server.APIKey)"),
        ]

        return components.url!
    }

    private func urlFromParameters(weatherIcon: String) -> URL {
        var components = URLComponents()
        components.scheme = RequestConstant.Server.APIScheme
        components.host = RequestConstant.Server.APIHostImage
        components.path = RequestConstant.Server.APIImage + "\(weatherIcon)" + "@2x.png"

        return components.url!
    }
}
