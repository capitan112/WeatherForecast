//
//  WeatherTableViewModelCellTest.swift
//  WeatherForecastTests
//
//  Created by Oleksiy Chebotarov on 01/03/2021.
//

@testable import WeatherForecast
import XCTest

class WeatherTableViewModelCellTest: XCTestCase {
    var subject: WeatherTableViewModelCell!
    var weatherInfo: WeatherInfo!

    override func setUpWithError() throws {
        weatherInfo = fetchWeatherInfo(json: weatherInfoJson)
    }

    override func tearDownWithError() throws {
        subject = nil
        weatherInfo = nil
        try super.tearDownWithError()
    }

    func testWeatherInfoForLondon() throws {
        // Given
        XCTAssertEqual(weatherInfo.weatherParameters.first?.name, "London")
        XCTAssertEqual(weatherInfo.weatherParameters.first?.temperature, 9.54)

        // When
        let weatherParameters = weatherInfo.weatherParameters.first!
        subject = WeatherTableViewModelCell(weatherParameters: weatherParameters)

        // Then
        XCTAssertEqual(subject.cityName, "London")
        XCTAssertEqual(subject.weatherIcon, "04d")

        let expectedStartColour = UIColor(hex: "#8aa3b4")!
        let expectedEndColour = UIColor(hex: "#466fcd")!
        XCTAssertEqual(subject.startColor, expectedStartColour)
        XCTAssertEqual(subject.endColor, expectedEndColour)
    }
}

private func fetchWeatherInfo(json: String) -> WeatherInfo {
    let jsonData = json.data(using: .utf8)!
    let weatherInfo: WeatherInfo = try! JSONDecoder().decode(WeatherInfo.self, from: jsonData)

    return weatherInfo
}

let weatherInfoJson = """
{
  "cnt": 1,
  "list": [
    {
      "coord": {
        "lon": -0.1257,
        "lat": 51.5085
      },
      "sys": {
        "country": "GB",
        "timezone": 0,
        "sunrise": 1614581143,
        "sunset": 1614620418
      },
      "weather": [
        {
          "id": 803,
          "main": "Clouds",
          "description": "broken clouds",
          "icon": "04d"
        }
      ],
      "main": {
        "temp": 9.54,
        "feels_like": 4.56,
        "temp_min": 7.78,
        "temp_max": 11.67,
        "pressure": 1032,
        "humidity": 76
      },
      "visibility": 6000,
      "wind": {
        "speed": 5.66,
        "deg": 100
      },
      "clouds": {
        "all": 75
      },
      "dt": 1614604181,
      "id": 2643743,
      "name": "London"
    }
  ]
}
"""
