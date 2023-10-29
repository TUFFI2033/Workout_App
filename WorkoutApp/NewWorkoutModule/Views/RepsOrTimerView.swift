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
    
    var (sets, reps, timer) = (0, 0, 0)
    
    private let setsViews = SliderView(name: "Sets", maxValue: 10, type: .sets)
    private let repsViews = SliderView(name: "Reps", maxValue: 50, type: .reps)
    private let timerViews = SliderView(name: "Timer", maxValue: 600, type: .timer)
        
    private let repeatOrTimerLabel = UILabel(text: "Choose repeat or timer")
    
    private lazy var stackView = UIStackView(arrangedSubviews: [setsViews, repeatOrTimerLabel, repsViews, timerViews], 
                                             axis: .vertical,
                                             spacing: 20)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
        setDelegates()
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
    
    private func setDelegates() {
        setsViews.delegate = self
        repsViews.delegate = self
        timerViews.delegate = self
    }
    
    func resetSliderViewValue() {
        setsViews.resetValues()
        repsViews.resetValues()
        timerViews.resetValues()
    }
}

// MARK: - SlidetViewProtocol

extension RepsOrTimerView: SlidetViewProtocol {
    func changeValue(type: SliderType, value: Int) {
        switch type {
        case .sets:
            sets = value
        case .reps:
            reps = value
            repsViews.isActive = true
            timerViews.isActive = false
            timer = 0
        case .timer:
            timer = value
            repsViews.isActive = false
            timerViews.isActive = true
            reps = 0
        }
    }
    
    
}

// MARK: - Set Constraints

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
