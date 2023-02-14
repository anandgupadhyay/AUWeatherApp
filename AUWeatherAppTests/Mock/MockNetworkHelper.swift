//
//  MockNetworkHelper.swift
//  AUWeatherApp
//
//  Created by Anand Upadhyay on 13/02/23.
//

import Foundation
@testable import AUWeatherApp

class MockNetworkHelper: NetworkServiceProtocol {
    static let shared = MockNetworkHelper()
    
    /// Load as Json from file
    /// - Parameter fileName: JSon file to load data from
    /// - Returns: data
    private static func loadFromJson(filename fileName: String) -> Data {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let dataObj = try Data(contentsOf: url)
                return dataObj
            } catch {
                print("error:\(error)")
            }
        }
        return Data()
    }
    
    func startNetworkTask(urlStr:String, params:[String:String], resultHandler: @escaping (Result<Data?, Error>) -> Void){
        Dispatch.background {
            let data = MockNetworkHelper.loadFromJson(filename: "SingleWeather")
            Dispatch.main{
                resultHandler(.success(data))
            }
        }
    }
}
