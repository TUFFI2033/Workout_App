//
//  BrownTextField.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 01/10/2023.
//

import UIKit

class BrownTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .specialLightBrown
        layer.cornerRadius = 10
        textColor = .specialGray
        font = .robotoBold20()
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        leftViewMode = .always
        clearButtonMode = .always
        returnKeyType = .done
        translatesAutoresizingMaskIntoConstraints = false
    }
}
