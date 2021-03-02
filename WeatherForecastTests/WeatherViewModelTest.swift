//
//  WeatherViewModelTest.swift
//  WeatherForecastTests
//
//  Created by Oleksiy Chebotarov on 01/03/2021.
//

import XCTest

class WeatherViewModelTest: XCTestCase {
    var subject: MockWeatherViewModel!
    override func setUpWithError() throws {
        subject = MockWeatherViewModel()
    }

    override func tearDownWithError() throws {
        subject = nil
    }

    func testFetchWeatherViewModel() throws {
        // Given
        XCTAssertFalse(subject.isFetchWeatherCalled)

        // When
        subject.fetchWeather()

        // Then
        XCTAssertTrue(subject.isFetchWeatherCalled)
    }
}
