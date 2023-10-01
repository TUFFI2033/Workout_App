//
//  RepsOrTimerView.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 01/10/2023.
//

import UIKit

class RepsOrTimerView: UIView {
    
    private let repsOrTimerLabel = UILabel(text: "Reps or timer")
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialLightBrown
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let setsViews = SliderView(name: "Sets", maxValue: 10)
    private let repsViews = SliderView(name: "Reps", maxValue: 50)
    private let timerViews = SliderView(name: "Timer", maxValue: 600)
    
    private let repeatOrTimerLabel = UILabel(text: "Choose repeat or timer")
    
    private lazy var stackView = UIStackView(arrangedSubviews: [setsViews, repeatOrTimerLabel, repsViews, timerViews], 
                                             axis: .vertical,
                                             spacing: 20)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        
        repeatOrTimerLabel.textAlignment = .center
        
        addSubview(repsOrTimerLabel)
        addSubview(backView)
        backView.addSubview(stackView)
    }
}

// MARK: Set Constraints

extension RepsOrTimerView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            repsOrTimerLabel.topAnchor.constraint(equalTo: topAnchor),
            repsOrTimerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            repsOrTimerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),

            backView.topAnchor.constraint(equalTo: repsOrTimerLabel.bottomAnchor, constant: 3),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -15),
        ])
    }
}
