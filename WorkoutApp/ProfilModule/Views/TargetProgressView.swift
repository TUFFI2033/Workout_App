//
//  TargetProgressView.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 05/11/2023.
//

import UIKit

class TargetProgressView: UIView {
    
    private let targetLabel = UILabel(text: "TARGET: 0 workouts",
                                      font: .robotoBold16(),
                                      textColor: .specialGray)
    private let workoutsNowLabel = UILabel(text: "0",
                                      font: .robotoBold24(),
                                      textColor: .specialGray)
    private let workoutsTargetLabel = UILabel(text: "20",
                                      font: .robotoBold24(),
                                      textColor: .specialGray)
    private lazy var stackWorkoutsTargetLabel = UIStackView(arrangedSubviews: [workoutsNowLabel, workoutsTargetLabel], axis: .horizontal, spacing: 10)
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.trackTintColor = .specialLightBrown
        progressView.progressTintColor = .specialGreen
        progressView.layer.cornerRadius = 14
        progressView.clipsToBounds = true
        progressView.setProgress(0, animated: false)
        progressView.layer.sublayers?[1].cornerRadius = 14
        progressView.subviews[1].clipsToBounds = true
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
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
        
        stackWorkoutsTargetLabel.distribution = .equalSpacing
        
        addSubview(targetLabel)
        addSubview(stackWorkoutsTargetLabel)
        addSubview(progressView)
    }
}


// MARK: Set Constraints

extension TargetProgressView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            targetLabel.topAnchor.constraint(equalTo: topAnchor),
            targetLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            targetLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            stackWorkoutsTargetLabel.topAnchor.constraint(equalTo: targetLabel.bottomAnchor, constant: 20),
            stackWorkoutsTargetLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackWorkoutsTargetLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            progressView.topAnchor.constraint(equalTo: stackWorkoutsTargetLabel.bottomAnchor, constant: 5),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
