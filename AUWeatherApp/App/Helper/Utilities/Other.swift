//
//  File1.swift
//  AUWeatherApp
//
//  Created by Anand Upadhyay on 09/02/23.
//

import Foundation
import UIKit

/// Extension for random value get.
extension CGFloat {
    // MARK: - Random Float Value
    static func randomValue() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension String {
    
    /// Convert ISO 8601 Date representation Date to Date object
    /// - Returns: Date object converted from String
    func convertToDate(format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        return dateFormatter.date(from: self)
    }
}

extension Int {
    /// Date from the Timestamp
    /// - Returns: Date from Timestamp
    func fromUnixTimeStamp() -> Date? {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        return date
    }
}

extension Date{
    
    /// Convert Date to String readable
    /// - Parameter format: format to be used default is Short
    /// - Returns: String representation of the date
    func convertToString(format: String = Constants.DateFormat_Short) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let formatedStringDate = dateFormatter.string(from: self)
        return formatedStringDate
    }
}

extension NSObject {
    // MARK: - Name of Class
    class var nameOfClass: String {
        return String(describing: self)
    }
}


/// Extension for random color using random value.
extension UIColor {
    // MARK: - Random Clor
    static func randomColor() -> UIColor {
        return UIColor(
            red:   .randomValue(),
            green: .randomValue(),
            blue:  .randomValue(),
            alpha: 1.0
        )
    }
}

extension Bundle {
    
    // MARK: - App Name
    var appName: String {
        object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
        object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
    }
}

enum AppUtility {
    
    // MARK: - Public API
    //    static var baseUrl: URL {
    //        URL(string: string(for: "WEATHER_API_BASE_URL"))!
    //    }
    
    /// Retrive value of a Key from Info dictionary
    /// - Parameter key: name of the key
    /// - Returns: value of key from info plist
    static func infoForKey(for key: String) -> String {
        Bundle.main.infoDictionary?[key] as! String
    }
}

typealias Dispatch = DispatchQueue

extension Dispatch {
    
    /// Run code as Background
    /// - Parameter task: task to run in background
    static func background(_ task: @escaping () -> ()) {
        Dispatch.global(qos: .background).async {
            task()
        }
    }
    
    /// Run code on Main thread
    /// - Parameter task: task to run on Main threar
    static func main(_ task: @escaping () -> ()) {
        Dispatch.main.async {
            task()
        }
    }
}



