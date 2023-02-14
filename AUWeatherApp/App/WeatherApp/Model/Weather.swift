//
//  Weather.swift
//  AUWeatherApp
//
//  Created by Anand Upadhyay on 10/02/23.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let coord: Coord?
    let weather: [WeatherElement]?
    let wind: Wind?
    let clouds: Clouds?
    let sys: Sys?
    let main: Main?
    let base: String?
    let visibility: Int?
    let dt: Int?
    let timezone, id: Int?
    let name: String?
    let cod: Int?
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double?
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int?
    let country: String?
    let sunrise, sunset: Int?
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let id: Int?
    let main, description, icon: String?
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
}

enum TemperatureFormat: String {
    case Celsius = "metric"
    case Fahrenheit = "imperial"
    case Kelvin = ""
}

struct NoCity: Codable {
    let cod, message: String?
}


/*
 Weather Report - Sampel Response for reference
 {
   "coord": {
     "lon": 36.8167,
     "lat": -1.2833
   },
   "weather": [
     {
       "id": 800,
       "main": "Clear",
       "description": "clear sky",
       "icon": "01d"
     }
   ],
   "base": "stations",
   "main": {
     "temp": 287.77,
     "feels_like": 286.93,
     "temp_min": 287.77,
     "temp_max": 287.77,
     "pressure": 1022,
     "humidity": 63
   },
   "visibility": 10000,
   "wind": {
     "speed": 2.06,
     "deg": 140
   },
   "clouds": {
     "all": 0
   },
   "dt": 1676261885,
   "sys": {
     "type": 1,
     "id": 2543,
     "country": "KE",
     "sunrise": 1676259744,
     "sunset": 1676303502
   },
   "timezone": 10800,
   "id": 184745,
   "name": "Nairobi",
   "cod": 200
 }
 */
