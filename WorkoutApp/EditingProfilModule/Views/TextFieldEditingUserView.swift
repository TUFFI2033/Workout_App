//
//  TextFieldEditingUserView.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 06/11/2023.
//

import UIKit

class TextFieldEditingUserView: UIView {
    
    private let userFirstNameLabel = UILabel(text: "First Name",
                                             font: .robotoMedium14(),
                                             textColor: .specialBrown)
    private let userSecondNameLabel = UILabel(text: "Second Name",
                                              font: .robotoMedium14(),
                                              textColor: .specialBrown)
    private let userHeightLabel = UILabel(text: "Height",
                                          font: .robotoMedium14(),
                                          textColor: .specialBrown)
    private let userWeightLabel = UILabel(text: "Weight",
                                          font: .robotoMedium14(),
                                          textColor: .specialBrown)
    private let userTargetLabel = UILabel(text: "Target",
                                          font: .robotoMedium14(),
                                          textColor: .specialBrown)
    
    let userFirstNameTextField = BrownTextField()
    let userSecondNameTextField = BrownTextField()
    let userHeightTextField = BrownTextField()
    let userWeightTextField = BrownTextField()
    let userTargetTextField = BrownTextField()
    
    private lazy var stackFirstName = UIStackView(
        arrangedSubviews: [userFirstNameLabel, userFirstNameTextField],
        axis: .vertical,
        spacing: 2)
    private lazy var stackSecondName = UIStackView(
        arrangedSubviews: [userSecondNameLabel, userSecondNameTextField],
        axis: .vertical,
        spacing: 2)
    private lazy var stackHeight = UIStackView(
        arrangedSubviews: [userHeightLabel, userHeightTextField],
        axis: .vertical,
        spacing: 2)
    private lazy var stackWeight = UIStackView(
        arrangedSubviews: [userWeightLabel, userWeightTextField],
        axis: .vertical,
        spacing: 2)
    private lazy var stackTarget = UIStackView(
        arrangedSubviews: [userTargetLabel, userTargetTextField],
        axis: .vertical,
        spacing: 2)
    
    private lazy var stack = UIStackView(
        arrangedSubviews: [stackFirstName, stackSecondName, stackHeight, stackWeight, stackTarget],
        axis: .vertical,
        spacing: 15)
    
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
        
        stack.distribution = .fillEqually
        
        addSubview(stack)
    }
}

// MARK: Set Constraints

extension TextFieldEditingUserView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            userFirstNameTextField.heightAnchor.constraint(equalToConstant: 40),
            userSecondNameTextField.heightAnchor.constraint(equalToConstant: 40),
            userHeightTextField.heightAnchor.constraint(equalToConstant: 40),
            userWeightTextField.heightAnchor.constraint(equalToConstant: 40),
            userTargetTextField.heightAnchor.constraint(equalToConstant: 40),
            
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
