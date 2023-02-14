//
//  HistoryProvider.swift
//  AUWeatherApp
//
//  Created by Anand Upadhyay on 14/02/23.
//

import Foundation
//MARK: - Userdefault Excetion to maintain history data
extension UserDefaults {
    var WeatherHistory: [[String:String]] {
        get { self.array(forKey: #function) as? [[String:String]] ?? [] }
        set { self.set(newValue, forKey: #function) }
    }
}

//MARK: - History List Provider
class HistoryProvider{
    
    static var weatherList: [Weather]?
    
    /// Save Weather History in User default
    /// - Parameter weather: Weather to be saved
    /// - Returns: boolean indicating the success of failure
    class func writeWeatherHistory(weather: Weather?) ->  Bool{
        guard weather != nil else{
            return false
        }
        let userDefaults = UserDefaults.standard
        do {
            //check if history list is emppty
            HistoryProvider.weatherList = HistoryProvider.readWeatherHistory()
            if (HistoryProvider.weatherList?.count ?? 0) <= 0 {
                //create array and add element
                weatherList = [weather!]
            }else{
                //check if max limit reached then replace replacing the first object
                if weatherList?.count == Constants.MaxHistoryCount {
                    weatherList?[0] = weather!
                }else{
                    weatherList?.append(weather!)
                }
            }
            
            let encodedData = try JSONEncoder().encode(weatherList)
            userDefaults.set(encodedData, forKey: AppKeys.WeatherList)
            userDefaults.synchronize()
            return true
        } catch {
            return false
        }
    }
    
    /// Read Weather History from User defaults
    /// - Returns: array of Weather [Weather]?
    class func readWeatherHistory() -> [Weather]?{
        let userDefaults = UserDefaults.standard
        if let savedData = userDefaults.object(forKey: AppKeys.WeatherList) as? Data {
            do{
                weatherList = try JSONDecoder().decode([Weather].self, from: savedData)
                return weatherList
            } catch {
                return nil
            }
        }else{
            return nil
        }
    }
    
    /// Clear Weather History
    /// - Returns: if able to clear history or not
    class func clearWeatherHistory(){
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: AppKeys.WeatherList)
    }
    
}
