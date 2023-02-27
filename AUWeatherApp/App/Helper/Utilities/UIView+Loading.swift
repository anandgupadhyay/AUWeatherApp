//
//  File1.swift
//  AUWeatherApp
//
//  Created by Anand Upadhyay on 09/02/23.
//

import Foundation
import UIKit

extension UIView{
    
    /// Simply zooming in of a view: set view scale to 0 and zoom to Identity on 'duration' time interval
    /// - Parameter duration: animation duration
    func zoomIn(duration: TimeInterval = 0.2,completion: ((Bool) -> Void)? = nil) {
        self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = .identity
        }) { (animationCompleted) -> Void in
            completion?(animationCompleted)
        }
    }
    
    /// Add A loading Indicator in View
    /// - Parameters:
    ///   - activityColor: color of the activity indicator
    ///   - interactionEnabled: interaction on / off default is false
    ///   - backgroundColor: backgournd color of the loading indicator default is UIColor.systemGroupedBackground
    func showLoading(activityColor: UIColor,interactionEnabled: Bool = false, backgroundColor: UIColor = .systemGroupedBackground) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width:  50, height: 50)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = Constants.LoadingIndicatorTag
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: backgroundView.frame.size.width, height: backgroundView.frame.size.height))
        activityIndicator.center = CGPoint(x: backgroundView.frame.size.width/2, y: backgroundView.frame.size.height/2)
        backgroundView.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = activityColor
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = interactionEnabled
        backgroundView.addSubview(activityIndicator)
        self.addSubview(backgroundView)
    }
    
    /// Hide Loading Indicator
    func hideLoading(){
        if let background = viewWithTag(Constants.LoadingIndicatorTag){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}

extension UIView{
    
    /// Add Shadow to view
    open func addDropShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.4
        layer.masksToBounds = true
    }
    
    /// A convenience function to turn off drop shadow
    open func removeDropShadow() {
        layer.shadowOpacity = 0
    }
    
    
    @discardableResult
    public class func fromNib<T: UIView>() -> T {
        let name = String(describing: Self.self);
        guard let nib = Bundle(for: Self.self).loadNibNamed(
            name, owner: nil, options: nil)
        else {
            fatalError("Missing nib-file named: \(name)")
        }
        return nib.first as! T
    }
    
    //Animate a button when clicked
    // usage: button.animate()
    func animate() {
          UIView.animate(withDuration: 0.1, animations: {
            self.transform = self.transform.scaledBy(x: 0.3, y: 0.3)
//            let image = UIImage(named: "BlackStar")
//            self.setImage(image, for: .normal)
          }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
//                let image = UIImage(named: "RedStar")
//                self.setImage(image, for: .normal)
            })
          })
    }
    
}


