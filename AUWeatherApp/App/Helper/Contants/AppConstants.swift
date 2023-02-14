//
//  AppConstants.swift
//  AUWeatherApp
//
//  Created by Anand Upadhyay on 09/02/23.
//

import Foundation

struct Constants{
    static let LoadingIndicatorTag = 961942
    static let DateFormat_Short = "YYYY-MM-DD"
    static let DateFormat_Long = "EEE, dd MMMM YYYY, hh:mm a"
    static let NodataViewSize = 200
    static let AnimationDuration = 0.25
    static let WeatherCellId = "MyWeatherCell"
    static let MaxHistoryCount = 5
}

//can be better implemented with Localisation
struct AppMessages {
    static let defaultError: String = "Something went wrong! Please try again later."
    static let selectLocation: String = "Please select location"
    static let searchLocation: String = "Please search location"
    static let noLocationFound: String = "No location found!"
    static let Refresh: String = "Refresh"
    static let AppTitle: String = "Weather App"
    static let searchCity: String = "Search city"
    static let cityList = "City List"
    static let WeatherHistoryTitle = "Weather History"
    static let NoWeatherHistoryMessage = "No history found"
    static let ClearHistoryTitle = "Clear History"
    
    enum WeatherMessage: String {
        case Winter = "❄️Cool❄️ Grab a Cappacino"
        case Summer = "🌞Its Hot🌞 Ice-cream time"
        case Monsoon = "🌧️Its Raining🌧️ Lets dance"
        case Spring = "🌼Relax🌼 Ride a bike"
    }
}

struct AppKeys{
    static let WeatherList = "WeatherList"
}
