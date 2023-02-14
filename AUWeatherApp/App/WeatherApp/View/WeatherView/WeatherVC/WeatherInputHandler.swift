//
//  WeatherInputHandler.swift
//  AUWeatherApp
//
//  Created by Anand Upadhyay on 11/02/23.
//

import Foundation
import UIKit

// MARK: - User's Location Choice Handling
extension WeatherViewController: LocationInputProtocol{
    
    
    /// Request User's Location
    func userSelectedMyLocation() {
        requestLocationAccess()
    }
    
    /// Open City List
    func openCityList() {
        let cityPickerVC = self.storyboard!.instantiateViewController(withIdentifier: "CityListViewController") as! CityListViewController
        cityPickerVC.delegate = self
        self.pushVC(destinationVC: cityPickerVC)
    }
    
    /// User's Search for location
    /// - Parameter location: location search key
    func userSearchedLocation(location: String) {
        locationManager.stopUpdatingLocation()
        if !location.trimmingCharacters(in: .whitespaces).isEmpty {
            getWeatherForSearchLocation(location: location)
        }else{
            self.showAlert(message: AppMessages.selectLocation)
        }
    }
}

// MARK: - City List's City Selection Handler
extension WeatherViewController: CityListProtocol{
    
    /// City Selected, Pass city id to handler
    /// - Parameter cityId: City Id
    func didSelectedCity(cityId: String) {
        getWeatherForSelectedCity(cityId: cityId)
    }
}
