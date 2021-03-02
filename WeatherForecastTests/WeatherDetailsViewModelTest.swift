//
//  WeatherDetailsViewModelTest.swift
//  WeatherForecastTests
//
//  Created by Oleksiy Chebotarov on 01/03/2021.
//

@testable import WeatherForecast
import XCTest

class WeatherDetailsViewModelTest: XCTestCase {
    var subject: WeatherDetailsViewModel!
    var weatherParameters: WeatherParameters!

    override func setUpWithError() throws {
        let weatherInfo = fetchWeatherInfo(json: weatherInfoJson)
        weatherParameters = weatherInfo.weatherParameters.first
    }

    override func tearDownWithError() throws {
        subject = nil
        weatherParameters = nil
    }

    func testWeatherDetailsForLondon() throws {
        // Given
        XCTAssertEqual(weatherParameters.name, "London")
        XCTAssertEqual(weatherParameters.temperature, 9.54)

        // When
        subject = WeatherDetailsViewModel(weatherParameters: weatherParameters)

        // Then

        let expectedStartColour = UIColor(hex: "#466fcd")!
        let expectedEndColour = UIColor(hex: "#8aa3b4")!
        
        XCTAssertEqual(subject.weatherDetails.cityName, "London")
        XCTAssertEqual(subject.weatherDetails.temperature, "10c")
        XCTAssertEqual(subject.weatherDetails.feelLike, "Feels like 5c")
        XCTAssertEqual(subject.weatherDetails.maxTemperature, "H 12c")
        XCTAssertEqual(subject.weatherDetails.minTemperature, "L 8c")
        XCTAssertEqual(subject.weatherDetails.weatherIcon, "04d")
        XCTAssertEqual(subject.weatherDetails.startColor, expectedStartColour)
        XCTAssertEqual(subject.weatherDetails.endColor, expectedEndColour)
    }

    private func fetchWeatherInfo(json: String) -> WeatherInfo {
        let jsonData = json.data(using: .utf8)!
        let weatherInfo: WeatherInfo = try! JSONDecoder().decode(WeatherInfo.self, from: jsonData)

        return weatherInfo
    }
}
