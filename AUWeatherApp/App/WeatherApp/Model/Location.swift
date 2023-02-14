//
//  Location.swift
//  AUWeatherApp
//
//  Created by Anand Upadhyay on 11/02/23.
//

import Foundation

//MARK: - Location
class User
{
    static var shared = User()
    var tempratureUnit: TemperatureFormat = .Celsius// User's temprature Unit
    
    /// Location Class
    class Location {
    static var shared = Location()
    
    private init() {}
    
    var latitude : Double!
    var longitude : Double!
    }
}
