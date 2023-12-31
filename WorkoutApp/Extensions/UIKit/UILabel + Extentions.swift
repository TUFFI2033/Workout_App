//
//  UILabel + Extentions.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 24/09/2023.
//

import UIKit

extension UILabel {
    convenience init(text: String) {
        self.init()
        self.text = text
        self.font = .robotoMedium14()
        self.textColor = .specialBrown
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.8
        self.translatesAutoresizingMaskIntoConstraints = false
    }    
    
    convenience init(text: String = "", font: UIFont?, textColor: UIColor) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
