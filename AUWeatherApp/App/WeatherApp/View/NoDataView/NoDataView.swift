//
//  NoDataView.swift
//  AUWeatherApp
//
//  Created by Anand Upadhyay on 09/02/23.
//

import Foundation
import UIKit

class NoDataView: UIView {
        // MARK: - IBOutlet
        @IBOutlet private weak var contentView: UIView!
        @IBOutlet private weak var lblNoData: UILabel!

        override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        func setupNoDataView()
        {
            contentView.removeFromSuperview()
            addSubview(contentView)
            lblNoData.text = AppMessages.noLocationFound
        }
        
        func setupSelectLocatin(){
            contentView.removeFromSuperview()
            addSubview(contentView)
            lblNoData.text = AppMessages.selectLocation
        }
    

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }

        private func commonInit() {
            UIView.fromNib()
            lblNoData.text = AppMessages.noLocationFound
            addSubview(contentView)
        }
}
