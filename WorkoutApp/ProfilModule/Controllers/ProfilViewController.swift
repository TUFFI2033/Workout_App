//
//  ProfilViewController.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 05/11/2023.
//

import UIKit

class ProfilViewController: UIViewController {
    
    private let characteristicUserAndPhotoView = СharacteristicUserAndPhotoView()
    private let workoutCollectionView = WorkoutCollectionView()
    private let targetProgressView = TargetProgressView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getResultWorkout()
        setupUserParameters()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        characteristicUserAndPhotoView.delegate = self
       
        view.addSubview(characteristicUserAndPhotoView)
        view.addSubview(workoutCollectionView)
        view.addSubview(targetProgressView)
    }
    
    private func getResultWorkout() {
        let nameArray = RealmManager.shared.getWorkoutsName()
        let workoutArray = RealmManager.shared.getResultWorkoutModel()
        
        for name in nameArray {
            let predicate = NSPredicate(format: "workoutName = '\(name)'")
            let filtredArray = workoutArray.filter(predicate).sorted(byKeyPath: "workoutName")
            var result = 0
            var image: Data?
            filtredArray.forEach { model in
                result += model.workoutReps * model.workoutSets
                image = model.workoutImage
            }
            
            let resultModel = ResultWorkout(name: name, result: result, imageData: image)
            workoutCollectionView.resultArray.append(resultModel)
        }
    }
    
    private func setupUserParameters() {
        let userArray = RealmManager.shared.getResultUserModel()
        
        if !userArray.isEmpty {
            characteristicUserAndPhotoView.nameUserLabel.text = userArray[0].userFirstName + " " + userArray[0].userSecondName
            characteristicUserAndPhotoView.userHeightLabel.text = "Height: \(userArray[0].userHeight)"
            characteristicUserAndPhotoView.userWeightLabel.text = "Weight: \(userArray[0].userWeight)"
            targetProgressView.targetLabel.text = "TARGET: \(userArray[0].userTarget)"
            targetProgressView.workoutsTargetLabel.text = "\(userArray[0].userTarget)"
            
            guard let data = userArray[0].userImage,
                  let image = UIImage(data: data) else {
                return
            }
            characteristicUserAndPhotoView.userPhotoImageView.image = image
            characteristicUserAndPhotoView.userPhotoImageView.contentMode = .scaleAspectFill
        }
    }
}

// MARK: CharacteristicUserAndPhotoViewDelegate

extension ProfilViewController: CharacteristicUserAndPhotoViewDelegate {
    func editingButtonTapped() {
        let editingProfilVC = EditingProfilViewController()
        editingProfilVC.modalPresentationStyle = .fullScreen
        present(editingProfilVC, animated: true)
    }
}

// MARK: Set Constraints

extension ProfilViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            characteristicUserAndPhotoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            characteristicUserAndPhotoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            characteristicUserAndPhotoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            characteristicUserAndPhotoView.heightAnchor.constraint(equalToConstant: 240),
            
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
