//
//  CityListProvider.swift
//  AUWeatherApp
//
//  Created by Anand Upadhyay on 10/02/23.
//

import Foundation
class CityListProvider{
    static var cityList: [City]?
    
    /// Get City List from JSOn file
    /// and return [City] or nil in case of error
    /// - Parameters:
    ///   - fileName: JSON File to load data from
    ///   - complete: Completion handler with Result<[City]?, Error>
    static func getCityList(fileName: String,complete: @escaping ( Result<[City]?, Error>)->()) {
        
        if (CityListProvider.cityList?.count ?? 0)>0{
            Dispatch.main {
                complete(.success(CityListProvider.cityList))
            }
            return
        }
        
        guard let citiesJSON = Bundle.main.path(forResource: fileName, ofType: "json") else {
            complete(.failure(.badUrl))
            return
        }
        
        Dispatch.background {
            do {
                let citiesData = try Data(contentsOf: URL(fileURLWithPath: citiesJSON), options: [])
                let cities = try JSONDecoder().decode([City].self, from: citiesData)
                CityListProvider.cityList = Array(Set(cities)).filter { !$0.country.isEmpty }
                Dispatch.main {
                    complete(.success(CityListProvider.cityList))
                }
            } catch {
                Dispatch.main {
                    complete(.failure(.dataCorrupted))
                }
            }
        }
    }
    
}
