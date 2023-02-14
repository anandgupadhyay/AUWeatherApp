//
//  WeatherLocationHandler.swift
//  AUWeatherApp
//
//  Created by Anand Upadhyay on 11/02/23.
//

import UIKit
import CoreLocation
import Foundation

// MARK: - User's Current Location Handling
extension WeatherViewController: CLLocationManagerDelegate{
    
    /// handle Location after received from Location Manager
    /// - Parameter location: Location
    func performLocationUpdate(location: CLLocation?){
        if let location = location{
            User.Location.shared.latitude = location.coordinate.latitude
            User.Location.shared.longitude = location.coordinate.longitude
            self.getWeatherForAvailableLocation(location: User.Location.shared)
        }
    }
    
    func requestLocationAccess(){
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
        else{
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            // Request the appropriate authorization based on the needs of the app
            manager.requestWhenInUseAuthorization()
        case .restricted:
            print("Sorry, restricted")
            // Optional: Offer to take user to app's settings screen
        case .denied:
            print("Sorry, denied")
            // Optional: Offer to take user to app's settings screen
        case .authorizedAlways, .authorizedWhenInUse:
            // The app has permission so start getting location updates
            manager.startUpdatingLocation()
        @unknown default:
            print("Unknown status")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Some location updates can be invalid or have insufficient accuracy.
        // Find the first location that has sufficient horizontal accuracy.
        // If the manager's desiredAccuracy is one of kCLLocationAccuracyNearestTenMeters,
        // kCLLocationAccuracyHundredMeters, kCLLocationAccuracyKilometer, or kCLLocationAccuracyThreeKilometers
        // then you can use $0.horizontalAccuracy <= manager.desiredAccuracy. Otherwise enter the number of meters desired.
        if let location = locations.first(where: { $0.horizontalAccuracy <= 50 }) {
            print("location found: \(location)")
            self.performLocationUpdate(location: locationManager.location)
            // stop updating Location if you don't need any more updates
            manager.stopUpdatingLocation()
        }else{
            showAlert(message: AppMessages.noLocationFound)
        }
    }
    
    private func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //Show Alert that Not able to fetch User's Location
        showAlert(message: error.localizedDescription)
    }
}
