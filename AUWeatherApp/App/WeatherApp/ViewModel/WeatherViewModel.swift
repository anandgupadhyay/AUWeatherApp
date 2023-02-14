//
//  WeatherViewModel.swift
//  AUWeatherApp
//
//  Created by Anand Upadhyay on 10/02/23.
//

import Foundation
class WeatherViewModel {
    
    private let apiService: NetworkServiceProtocol
    init(apiService: NetworkServiceProtocol = NetworkHelper()) {
        self.apiService = apiService
    }
    
    //create observers
    internal var location: AppObserver<String> = AppObserver("")
    internal let weatherModel: AppObserver<Weather?> = AppObserver(nil)
    
    /// Fetch Weather
    /// - Parameters:
    ///   - params: Parameters q:Location, lat: lattitude, log: longitutude, appid: API key, unit: Metric: Celsius, Imperial: Fahrenheit default is Kelvin
    ///   - complete: Completion block with Result<AppObserver<Weather?>, Error>
    internal func fetchWeather(params:[String:String], complete: @escaping ( Result<AppObserver<Weather?>, Error>)->()) {
        
        self.apiService.startNetworkTask(urlStr: NetworkHelperConstants.weatherURL, params: params) { result in
            switch result {
            case .success(let dataObject):
                do {
//                    let convertedString = String(data: dataObject ?? Data(), encoding: .utf8)
//                    print("Response: \(convertedString ?? "No Data")")
                    let decoderObject = JSONDecoder()
                    self.weatherModel.value = try decoderObject.decode(Weather.self, from: dataObject!)
                    complete(.success(self.weatherModel))
                }
                catch{
                    do {
                        self.weatherModel.value = nil
                        let decoderObject = JSONDecoder()
                        let someCode:NoCity? = try decoderObject.decode(NoCity.self, from: dataObject!)
                        if someCode != nil{
                            print(someCode!.message as Any)
                            complete(.failure(.other(someCode!.message! )))
                        }else{
                            complete(.failure(.other(error.localizedDescription)))
                        }
                    }
                    catch{
                        complete(.failure(.other(error.localizedDescription)))
                    }
                }
                
            case .failure(let error):
                self.weatherModel.value = nil
                complete(.failure(.other(error.localizedDescription)))
            }
        }
    }
}
