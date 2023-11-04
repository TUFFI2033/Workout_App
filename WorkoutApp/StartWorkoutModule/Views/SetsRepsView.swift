//
//  SetsRepsView.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 29/10/2023.
//

import UIKit

protocol NextSetProtocol: AnyObject {
    func nextSetTapped()
    func editingTapped()
}

class SetsRepsView: UIView {
    
    weak var cellNextSetDelegate: NextSetProtocol?
    
    private let workoutNameLabel = UILabel(text: "Squats", font: .robotoMedium24(), textColor: .specialGray)
    private let setsLabel = UILabel(text: "Sets", font: .robotoMedium18(), textColor: .specialGray)
    private let countSetsLabel = UILabel(text: "1/4", font: .robotoMedium18(), textColor: .specialGray)
    private let repsOrTimeLabel = UILabel(text: "Reps", font: .robotoMedium18(), textColor: .specialGray)
    private let countRepsOrTimeLabel = UILabel(text: "20", font: .robotoMedium18(), textColor: .specialGray)
    
    private lazy var editingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Editing", for: .normal)
        button.setTitleColor(.specialBrown, for: .normal)
        button.setImage(UIImage(named: "editing"), for: .normal)
        button.titleLabel?.font = .robotoMedium16()
        button.backgroundColor = .specialLightBrown
        button.addTarget(self, action: #selector(editingButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nextSetButton: UIButton = {
        let button = UIButton()
        button.setTitle("NEXT SET", for: .normal)
        button.setTitleColor(.specialGray, for: .normal)
        button.titleLabel?.font = .robotoBold16()
        button.backgroundColor = .specialYellow
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(nextSetButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let borderSets = UIView()
    private let borderReps = UIView()
    private lazy var stackSets = UIStackView(
        arrangedSubviews: [setsLabel, countSetsLabel],
        axis: .horizontal,
        spacing: 10)
    private lazy var stackReps = UIStackView(
        arrangedSubviews: [repsOrTimeLabel, countRepsOrTimeLabel],
        axis: .horizontal,
        spacing: 10)
    
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
        backgroundColor = .specialLightBrown
        layer.cornerRadius = 10
        
        workoutNameLabel.textAlignment = .center
        stackSets.distribution = .equalSpacing
        stackReps.distribution = .equalSpacing
        borderSets.backgroundColor = .specialBrown
        borderReps.backgroundColor = .specialBrown
        borderSets.translatesAutoresizingMaskIntoConstraints = false
        borderReps.translatesAutoresizingMaskIntoConstraints = false
    
        addSubview(workoutNameLabel)
        addSubview(stackSets)
        addSubview(stackReps)
        addSubview(borderSets)
        addSubview(borderReps)
        addSubview(editingButton)
        addSubview(nextSetButton)
    }
    
    @objc private func nextSetButtonTapped() {
        cellNextSetDelegate?.nextSetTapped()
    }
    
    @objc private func editingButtonTapped() {
        cellNextSetDelegate?.editingTapped()
    }
    
    func refreshLabels(model: WorkoutModel, numberOfSet: Int) {
        workoutNameLabel.text = model.workoutName
        countSetsLabel.text = "\(numberOfSet)/\(model.workoutSets)"
        if model.workoutReps != 0 {
            countRepsOrTimeLabel.text = "\(model.workoutReps)"
        } else {
            repsOrTimeLabel.text = "Time of Set"
            countRepsOrTimeLabel.text = "\(model.workoutTimer.getTimeFromSeconds())"
        }
    }
    
    func buttonsIsEnable(_ value: Bool) {
        editingButton.isEnabled = value
        nextSetButton.isEnabled = value
    }
}

// MARK: Set Constraints

extension SetsRepsView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            workoutNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            workoutNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            workoutNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            
            stackSets.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor, constant: 10),
            stackSets.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackSets.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            borderSets.topAnchor.constraint(equalTo: stackSets.bottomAnchor, constant: 1),
            borderSets.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            borderSets.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            borderSets.heightAnchor.constraint(equalToConstant: 1),
            
            stackReps.topAnchor.constraint(equalTo: stackSets.bottomAnchor, constant: 20),
            stackReps.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackReps.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            borderReps.topAnchor.constraint(equalTo: stackReps.bottomAnchor, constant: 1),
            borderReps.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            borderReps.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            borderReps.heightAnchor.constraint(equalToConstant: 1),
            
            editingButton.topAnchor.constraint(equalTo: borderReps.bottomAnchor, constant: 10),
            editingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            editingButton.heightAnchor.constraint(equalToConstant: 25),
            editingButton.widthAnchor.constraint(equalToConstant: 75),
            
            nextSetButton.topAnchor.constraint(equalTo: editingButton.bottomAnchor, constant: 10),
            nextSetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nextSetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextSetButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
}
