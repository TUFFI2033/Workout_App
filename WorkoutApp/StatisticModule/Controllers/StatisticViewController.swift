//
//  ViewController.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 27/09/2023.
//

import UIKit

class StatisticViewController: UIViewController {
    
    private let statisticLabel: UILabel = {
        let label = UILabel()
        label.text = "STATISTICS"
        label.textColor = .specialGray
        label.font = .robotoBold24()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl(items: ["Week", "Month"])
        segmented.backgroundColor = .specialGreen
        segmented.selectedSegmentIndex = 0
        segmented.selectedSegmentTintColor = .specialYellow
        segmented.setTitleTextAttributes([.font : UIFont.robotoMedium16() as Any,
                                          .foregroundColor : UIColor.white],for: .normal)
        segmented.setTitleTextAttributes([.font : UIFont.robotoMedium16() as Any,
                                          .foregroundColor : UIColor.specialGray], for: .selected)
        segmented.addTarget(self, action: #selector(segmentedChange), for: .valueChanged)
        segmented.translatesAutoresizingMaskIntoConstraints = false
        return segmented
    }()
    
    private let nameTextField = BrownTextField()
    private let exercisesLabel = UILabel(text: "Exercises")
    private let tableView = StatisticTableView()

    private var differenceArray = [DifferenceWorkout]()
    private var filtredArray = [DifferenceWorkout]()
    private var isFiltred = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        segmentedChange()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        nameTextField.brownDelegate = self
        
        view.addSubview(statisticLabel)
        view.addSubview(segmentedControl)
        view.addSubview(nameTextField)
        view.addSubview(exercisesLabel)
        view.addSubview(tableView)
    }
    
    @objc private func segmentedChange() {
        let todayDate = Date()
        differenceArray = [DifferenceWorkout]()
        
        if segmentedControl.selectedSegmentIndex == 0 {
            let dateStart = todayDate.offsetDay(days: -7)
            getDifferenceModels(dateStart: dateStart)
        } else {
            let dateStart = todayDate.offsetMonth(month: 1)
            getDifferenceModels(dateStart: dateStart)
        }
        
        tableView.setDifferenceArray(differenceArray)
        tableView.reloadData()
    }
    
    private func getWorkoutsName() -> [String] {
        var nameArray = [String]()
        
        let allWorkouts = RealmManager.shared.getResultWorkoutModel()
        
        for workoutModel in allWorkouts {
            if !nameArray.contains(workoutModel.workoutName) {
                nameArray.append(workoutModel.workoutName)
            }
        }
        
        return nameArray
    }
    
    private func getDifferenceModels(dateStart: Date) {
        let dateEnd = Date()
        let nameArray = getWorkoutsName()
        let allWorkouts = RealmManager.shared.getResultWorkoutModel()
        var workoutArray = [WorkoutModel]()
        
        for name in nameArray {
            let predicate = NSPredicate(format: "workoutName = '\(name)' AND workoutDate BETWEEN %@", [dateStart, dateEnd])
            let filtredArray = allWorkouts.filter(predicate).sorted(byKeyPath: "workoutDate")
            workoutArray = filtredArray.map { $0 }
            
            guard let last = workoutArray.last?.workoutReps,
                  let first = workoutArray.first?.workoutReps else {
                return
            }
            let differenceWorkout = DifferenceWorkout(name: name, lastReps: last, firstReps: first)
            differenceArray.append(differenceWorkout)
        }
    }
    
    func filtringWorkouts(text: String) {
        
        for workout in differenceArray {
            if workout.name.lowercased().contains(text.lowercased()) {
                filtredArray.append(workout)
            }
        }
    }
}

//MARK: - BrownTextFieldProtocol

extension StatisticViewController: BrownTextFieldProtocol {
    func typing(range: NSRange, replacementString: String) {
        if let text = nameTextField.text,
           let textRange = Range(range, in: text) {
            let updateText = text.replacingCharacters(in: textRange, with: replacementString)
            
            filtredArray = [DifferenceWorkout]()
            isFiltred = updateText.count > 0
            filtringWorkouts(text: updateText)
        }
        
        if isFiltred {
            tableView.setDifferenceArray(filtredArray)
        } else {
            tableView.setDifferenceArray(differenceArray)
        }
        tableView.reloadData()
    }
    
    func clear() {
//        isFiltred = false
//        differenceArray = [DifferenceWorkout]()
//        getDifferenceModels(dateStart: Date().offsetDay(days: 7))
        tableView.setDifferenceArray(differenceArray)
        tableView.reloadData()
    }
}

// MARK: Set Constraints

extension StatisticViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            statisticLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            statisticLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: statisticLabel.bottomAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            nameTextField.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 35),
            
            exercisesLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            exercisesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            exercisesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: exercisesLabel.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)

        ])
    }
}
