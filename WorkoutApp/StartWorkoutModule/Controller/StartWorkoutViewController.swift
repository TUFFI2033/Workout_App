//
//  StartWorkoutViewController.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 29/10/2023.
//

import UIKit

class StartWorkoutViewController: UIViewController {
    
    private let startWorloutLabel: UILabel = {
        let label = UILabel()
        label.text = "START WORKOUT"
        label.textColor = .specialGray
        label.font = .robotoBold24()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageOrTimerView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "sportsman")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.text = "Details"
        label.textColor = .specialBrown
        label.font = .robotoMedium14()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let closeButton = CloseButton()
    private let setsRepsView = SetsRepsView()
    private let finishButton = GreenButton(text: "FINISH")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        finishButton.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
        
        view.addSubview(startWorloutLabel)
        view.addSubview(imageOrTimerView)
        view.addSubview(closeButton)
        view.addSubview(detailsLabel)
        view.addSubview(setsRepsView)
        view.addSubview(finishButton)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func finishButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: Set Constraints

extension StartWorkoutViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            startWorloutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            startWorloutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.heightAnchor.constraint(equalToConstant: 27),
            closeButton.widthAnchor.constraint(equalToConstant: 27),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            imageOrTimerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            imageOrTimerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            imageOrTimerView.topAnchor.constraint(equalTo: startWorloutLabel.bottomAnchor, constant: 40),
            
            detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            detailsLabel.topAnchor.constraint(equalTo: imageOrTimerView.bottomAnchor, constant: 30),
            
            setsRepsView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 5),
            setsRepsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            setsRepsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            setsRepsView.bottomAnchor.constraint(equalTo: finishButton.topAnchor, constant: -20),
            
            finishButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
