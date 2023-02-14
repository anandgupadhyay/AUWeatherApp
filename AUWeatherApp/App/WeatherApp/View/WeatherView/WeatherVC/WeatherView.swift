//
//  WeatherView.swift
//  AUWeatherApp
//
//  Created by Anand Upadhyay on 11/02/23.
//
import UIKit
import Foundation

// MARK: - Weather UI
class WeatherView: UIView {
    
    ///Outlets
    @IBOutlet weak private var lblCity: UILabel!
    @IBOutlet weak private var lblCountry: UILabel!
    @IBOutlet weak private var lblComment: UILabel!
    @IBOutlet weak private var lblMinTemp: UILabel!
    @IBOutlet weak private var lblMaxTemp: UILabel!
    @IBOutlet weak private var lblDate: UILabel!
    @IBOutlet weak private var lblWeatherDescription: UILabel!
    @IBOutlet weak private var lblTemperature: UILabel!
    @IBOutlet weak var imgWeather: MyExtendedImage!
    
    
    /// Update the UI
    /// - Parameter weather: Weather to update UI from
    func update(with weather: Weather){
        let temperature = weather.main?.temp
        switch temperature!{
        case ...15.0:
            lblComment.text = AppMessages.WeatherMessage.Winter.rawValue
        case 15.1...25.0:
            lblComment.text = AppMessages.WeatherMessage.Spring.rawValue
        case 25.1...:
            lblComment.text = AppMessages.WeatherMessage.Summer.rawValue
        default: break
        }
        
        //load image for the weather
        if let iconId = weather.weather?.first?.icon {
            imgWeather.loadImageWithUrl(URL(string: "\(NetworkHelperConstants.imageURL)\(iconId)@2x.png")!)
        }
        
        setupDateLabel(with: weather)
        lblMinTemp.text = String(format: "%.f°", (weather.main?.tempMin ?? 0))
        lblMaxTemp.text = String(format: "%.f°", (weather.main?.tempMax ?? 0))
        lblCity.text = weather.name
        lblCountry.text = weather.sys?.country
        lblWeatherDescription.text = weather.weather?.first?.description
        
        let tempUnit: NSString
        switch User.shared.tempratureUnit{
        case .Celsius:
            tempUnit = "C"
        case .Fahrenheit:
            tempUnit = "F"
        case .Kelvin:
            tempUnit = "K"
        }
        animate(text: String(format: "%.f°\(tempUnit)", (weather.main?.temp ?? 0)), with: .curveEaseIn)
    }
    
    func setupDateLabel(with weather: Weather){
        let date: String
        if weather.dt != nil {
            var timestampe = weather.dt ?? 0
            let timezoneDiff = weather.timezone ?? 0
            timestampe += timezoneDiff
            let weatherDate = timestampe.fromUnixTimeStamp()
            date =  " \(weatherDate?.convertToString(format: Constants.DateFormat_Long) ?? "")"
        }else{
            date =  " \(Date().convertToString(format: Constants.DateFormat_Long))"
        }
        lblDate.text = date
    }
    
    ///Animate temprature label
    private func animate(text: String, with options: UIView.AnimationOptions) {
        UIView.transition(with: lblTemperature,
                          duration: Constants.AnimationDuration,
                          options: options,
                          animations: { [weak self] in
            self?.lblTemperature.text = text
        }, completion: nil)
    }
}

