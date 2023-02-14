//
//  WeatherWebServiceHandler.swift
//  AUWeatherApp
//
//  Created by Anand Upadhyay on 11/02/23.
//

import Foundation
import UIKit

// MARK: - Web Service Calling
extension WeatherViewController {
    
    /// Get Weather information for User's Location as in Lat & Lon
    /// - Parameter location: user's location
    func getWeatherForAvailableLocation(location: User.Location){
        print("Lat:\(location.latitude!)")
        print("Lat:\(location.longitude!)")
        let lat = String(location.latitude)
        let lon = String(location.longitude)
        let params : [String : String] = ["lat" : lat , "lon" : lon, "units" : User.shared.tempratureUnit.rawValue, "appid" : NetworkHelperConstants.weatherAPIKey]
        fetchWeather(params: params)
    }
    
    /// Get Weather information for user's selected city
    /// - Parameter cityId: id of the city
    func getWeatherForSelectedCity(cityId: String){
        let params : [String : String] = ["id" : cityId , "units" : User.shared.tempratureUnit.rawValue, "appid" : NetworkHelperConstants.weatherAPIKey]
        fetchWeather(params: params)
    }
    
    /// Get weather information for user's Searched Location
    /// - Parameter location: user's search key
    func getWeatherForSearchLocation(location: String){
        let params : [String : String] = ["q" : location , "units" : User.shared.tempratureUnit.rawValue,"appid" : NetworkHelperConstants.weatherAPIKey]
        fetchWeather(params: params)
    }
    
    
    /// Actually Fetches the Weather
    /// - Parameter params: Parameters for fetching weather information
    func fetchWeather(params: [String:String]){
        
        if Reachability.shared.status == .connectedViaWiFi || Reachability.shared.status == .connectedViaCellular {
        self.tblWeather.isHidden = false
        self.tblWeather.showLoading(activityColor: .link)
        weatherVM.fetchWeather(params: params) { result in
            self.tblWeather.hideLoading()
            switch result {
            case .success(_):
                let _ = HistoryProvider.writeWeatherHistory(weather: self.weatherVM.weatherModel.value)
//                print("History Saved:\(saved ? "Yes" : "No")")
                //No need to handle UI Updates here as whenever a new weather will be updated and the binding will take place and trigger UI Update
            case .failure(let error):
                self.showAlert(message: error.localizedDescription)
            }
        }
        }else{
            self.showAlert(message: Error.network.localizedDescription)
        }
    }
}
