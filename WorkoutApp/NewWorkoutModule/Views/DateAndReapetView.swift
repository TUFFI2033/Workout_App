//
//  DateAndReapetView.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 01/10/2023.
//

import UIKit

class DateAndReapetView: UIView {
    
    private let dateAndRepeatLable = UILabel(text: "Date and repeat")
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialLightBrown
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateLabel = UILabel(text: "Date",
                                    font: .robotoMedium18(),
                                    textColor: .specialGray)
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.tintColor = .specialGreen
        return picker
    }()
    
    private let repeatLabel = UILabel(text: "Repeat every 7 days",
                                    font: .robotoMedium18(),
                                    textColor: .specialGray)
    
    private let repeatSwitch: UISwitch = {
        let repeatSwitch = UISwitch()
        repeatSwitch.isOn = true
        repeatSwitch.onTintColor = .specialGreen
        return repeatSwitch
    }()
    
    private lazy var dateStackView = UIStackView(arrangedSubviews: [dateLabel, datePicker], axis: .horizontal, spacing: 10)
    private lazy var repeatStackView = UIStackView(arrangedSubviews: [repeatLabel, repeatSwitch], axis: .horizontal, spacing: 10)
    private lazy var dateAndRepeatStackView = UIStackView(arrangedSubviews: [dateStackView, repeatStackView], axis: .vertical, spacing: 10)
    
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
        dateStackView.distribution = .equalSpacing
        repeatStackView.distribution = .equalSpacing
        
        addSubview(dateAndRepeatLable)
        addSubview(backView)
        addSubview(dateAndRepeatStackView)
    }
}

// MARK: Set Constraints

extension DateAndReapetView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dateAndRepeatLable.topAnchor.constraint(equalTo: topAnchor),
            dateAndRepeatLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            dateAndRepeatLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            dateAndRepeatLable.heightAnchor.constraint(equalToConstant: 16),
            
            backView.topAnchor.constraint(equalTo: dateAndRepeatLable.bottomAnchor, constant: 3),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            dateAndRepeatStackView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            dateAndRepeatStackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            dateAndRepeatStackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
        ])
    }
}
