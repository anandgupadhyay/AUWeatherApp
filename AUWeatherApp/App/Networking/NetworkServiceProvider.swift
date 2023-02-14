//
//  NetworkServiceProvider.swift
//  AUWeatherApp
//
//  Created by Anand Upadhyay on 09/02/23.
//

import Foundation
protocol NetworkServiceProtocol {
    func startNetworkTask(urlStr:String, params:[String:String], resultHandler: @escaping (Result<Data?, Error>) -> Void)
}

class NetworkHelper: NetworkServiceProtocol {
    static let shared = NetworkHelper()
    
    func startNetworkTask(urlStr:String, params:[String:String], resultHandler: @escaping (Result<Data?, Error>) -> Void){
        Dispatch.background {
            guard let urlComp = NSURLComponents(string: urlStr)else{
                resultHandler(.failure(.badUrl))
                return
            }
            
            if params.count>0{
                var items = [URLQueryItem]()
                for (key,value) in params {
                    items.append(URLQueryItem(name: key, value: value))
                }
                items = items.filter{!$0.name.isEmpty}
                if !items.isEmpty {
                    urlComp.queryItems = items
                }
            }
            let urlRequest = URLRequest(url: urlComp.url!)
            
            URLSession.shared.dataTask(with: urlRequest) { dataObject, responseObj, errorObject in
                Dispatch.main{
                    if let error = errorObject {
                        resultHandler(.failure(.other(error.localizedDescription)))
                    } else {
                        resultHandler(.success(dataObject))
                    }
                }
            }.resume()
        }
    }
}
