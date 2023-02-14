//
//  WeatherDataSource+Delegate.swift
//  AUWeatherApp
//
//  Created by Anand Upadhyay on 11/02/23.
//
import UIKit
import Foundation

extension WeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if weatherVM.weatherModel.value?.weather != nil {
            return 1
        }else{ return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.WeatherCellId)  else {
            return UITableViewCell()
        }
        
        //Access the weather view from Cell and provide weather information to update ui
        let weatherView = cell.contentView.viewWithTag(1) as! WeatherView
        if weatherVM.weatherModel.value?.weather != nil {
            let weather = weatherVM.weatherModel.value!
            weatherView.update(with: weather)
        }
        return cell
    }
}
