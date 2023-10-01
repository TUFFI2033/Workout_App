//
//  NewWorkoutViewController.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 01/10/2023.
//

import UIKit

class NewWorkoutViewController: UIViewController {
    
    private let newWorkoutLabel = UILabel(text: "NEW WORKOUT",
                                          font: .robotoMedium24(),
                                          textColor: .specialGray)
    
    private lazy var closeButton = ClaseButton(type: .system)
    private let nameView = NameView()
    private let dateAndRepeatView = DateAndReapetView()
    private let repsOrTimerView = RepsOrTimerView()
    private let saveButton = GreenButton(text: "SAVE")
    
    private lazy var stackView = UIStackView(arrangedSubviews: [nameView, dateAndRepeatView, repsOrTimerView],
                                             axis: .vertical,
                                             spacing: 20)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setConstraints()
    }

    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        newWorkoutLabel.textAlignment = .center
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        view.addSubview(newWorkoutLabel)
        view.addSubview(closeButton)
        view.addSubview(stackView)
        view.addSubview(saveButton)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: Set Constraints

extension NewWorkoutViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            newWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            newWorkoutLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newWorkoutLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            closeButton.centerYAnchor.constraint(equalTo: newWorkoutLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 33),
            closeButton.heightAnchor.constraint(equalToConstant: 33),
            
            nameView.heightAnchor.constraint(equalToConstant: 60),
            dateAndRepeatView.heightAnchor.constraint(equalToConstant: 115),
            repsOrTimerView.heightAnchor.constraint(equalToConstant: 340),
            
            stackView.topAnchor.constraint(equalTo: newWorkoutLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            saveButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
