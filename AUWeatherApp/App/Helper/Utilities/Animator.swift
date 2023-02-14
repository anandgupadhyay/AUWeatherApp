//
//  File1.swift
//  AUWeatherApp
//
//  Created by Anand Upadhyay on 09/02/23.
//

import Foundation
import UIKit

class Animator: UIViewController, CAAnimationDelegate {

    static let kSlideAnimationDuration: CFTimeInterval = 0.4

    static func viewSlideInFromRight(toLeft views: UIView){
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.type = CATransitionType.push
        transition?.subtype = CATransitionSubtype.fromRight
        transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition?.duration = kSlideAnimationDuration
        views.layer.add(transition!, forKey: nil)
    }

    static func viewSlideInFromLeft(toRight views: UIView){
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.type = CATransitionType.push
        transition?.subtype = CATransitionSubtype.fromLeft
        transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition?.duration = kSlideAnimationDuration
        views.layer.add(transition!, forKey: nil)
    }

    static func viewSlideInFromTop(toBottom views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.type = CATransitionType.push
        transition?.subtype = CATransitionSubtype.fromBottom
        transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition?.duration = kSlideAnimationDuration
        views.layer.add(transition!, forKey: nil)
    }

    static func viewSlideInFromBottom(toTop views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.type = CATransitionType.push
        transition?.subtype = CATransitionSubtype.fromTop
        
        transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition?.duration = kSlideAnimationDuration
        views.layer.add(transition!, forKey: nil)
    }
}
