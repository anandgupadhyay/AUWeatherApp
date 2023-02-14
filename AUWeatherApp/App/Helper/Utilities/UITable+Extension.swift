//
//  UITable+Extension.swift
//  AUWeatherApp
//
//  Created by Anand Upadhyay on 11/02/23.
//

import Foundation
import UIKit

extension UITableView {
    
    public func adjustSeperatorInsent() {
        // Force your tableview margins (this may be a bad idea)
        if self.responds(to: #selector(setter: UITableView.separatorInset)) {
            self.separatorInset = .zero
        }
        if self.responds(to: #selector(setter: UITableView.layoutMargins)) {
            self.layoutMargins = .zero
        }
    }
}
