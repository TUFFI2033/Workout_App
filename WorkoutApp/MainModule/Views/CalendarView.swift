//
//  CalendarView.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 02/09/2023.
//

import UIKit

class CalendarView: UIView {
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = #colorLiteral(red: 0.2, green: 0.5529411765, blue: 0.4901960784, alpha: 1)
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: Set Constraints

extension CalendarView {
    
    private func setConstraints () {
        NSLayoutConstraint.activate([
            
        ])
    }
}
