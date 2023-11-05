//
//  ProfilViewController.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 05/11/2023.
//

import UIKit

class ProfilViewController: UIViewController {
    
    private let profilLabel: UILabel = {
        let label = UILabel()
        label.text = "PROFILE"
        label.textColor = .specialGray
        label.font = .robotoBold24()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let characteristicUserAndPhotoView = СharacteristicUserAndPhotoView()
    private let workoutCollectionView = WorkoutCollectionView()
    private let targetProgressView = TargetProgressView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
       
        view.addSubview(profilLabel)
        view.addSubview(characteristicUserAndPhotoView)
        view.addSubview(workoutCollectionView)
        view.addSubview(targetProgressView)
    }
}

// MARK: Set Constraints

extension ProfilViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            profilLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            characteristicUserAndPhotoView.topAnchor.constraint(equalTo: profilLabel.bottomAnchor, constant: 20),
            characteristicUserAndPhotoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            characteristicUserAndPhotoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            characteristicUserAndPhotoView.heightAnchor.constraint(equalToConstant: 200),
            
            workoutCollectionView.topAnchor.constraint(equalTo: characteristicUserAndPhotoView.bottomAnchor, constant: 20),
            workoutCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            workoutCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            workoutCollectionView.heightAnchor.constraint(equalToConstant: 250),
            
            targetProgressView.topAnchor.constraint(equalTo: workoutCollectionView.bottomAnchor, constant: 20),
            targetProgressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            targetProgressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            targetProgressView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}
