//
//  City.swift
//  AUWeatherApp
//
//  Created by Anand Upadhyay on 10/02/23.
//

import Foundation

//MARK: - City
struct City: Decodable {
    let id: Int
    let name: String
    let country: String
}

extension City: Hashable {
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

/*
 
 Single City - for reference
 {
   "id": 1279233,
   "name": "Ahmedabad",
   "state": "",
   "country": "IN",
   "coord": {
     "lon": 72.616669,
     "lat": 23.033333
   }
 }
 
 */
