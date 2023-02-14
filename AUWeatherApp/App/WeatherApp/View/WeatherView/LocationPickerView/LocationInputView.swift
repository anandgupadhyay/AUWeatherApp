//
//  LocationInputView.swift
//  AUWeatherApp
//
//  Created by Anand Upadhyay on 11/02/23.
//

import UIKit


// MARK: - Location Input Protocol
protocol LocationInputProtocol: AnyObject {
    func userSelectedMyLocation()
    func openCityList()
    func userSearchedLocation(location: String)
}

// MARK: - User's Location Related Input Choice UI
class LocationInputView: UIView{
    
    /// Outlets
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var txtLocation: UITextField! {
        didSet {
            txtLocation.delegate = self
            txtLocation.placeholder =  " \(AppMessages.searchLocation)"
            txtLocation.accessibilityIdentifier = "TextLocation"
        }
    }
    @IBOutlet weak var btnMyLocation: UIButton!
    
    @IBOutlet weak var hstackInputViews: UIStackView! {
        didSet {
            hstackInputViews.isAccessibilityElement = false
        }
    }
    //Protocol
    unowned var delegate: LocationInputProtocol?
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    ///Close Keyboard and if required clear the textfield
    func closeKeyboard(isClear: Bool){
        txtLocation.resignFirstResponder()
        if isClear{
            txtLocation.text = ""
        }
    }
    
    /// My Location Button Tap Event
    /// - Parameter sender: My Location button
    @IBAction func myLocationButtonTap(_ sender: UIButton) {
        sender.zoomIn { _ in
            DispatchQueue.main.async {
            self.closeKeyboard(isClear: true)
            self.delegate?.userSelectedMyLocation()
            }
        }
    }
    
    /// Search Button Tap Event
    /// - Parameter sender: Search Button
    @IBAction func searchButtonTap(_ sender: UIButton) {
        sender.zoomIn { _ in
            DispatchQueue.main.async {
                self.closeKeyboard(isClear: true)
                self.delegate?.openCityList()
            }
        }
    }
}

// MARK: - TextField Event Handling
extension LocationInputView: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.closeKeyboard(isClear: false)
        self.delegate?.userSearchedLocation(location: textField.text ?? "")
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
}


