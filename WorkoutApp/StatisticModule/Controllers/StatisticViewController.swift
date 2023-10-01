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
    
    private let exercisesLabel = UILabel(text: "Exercises")
    private let tableView = StatisticTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(statisticLabel)
        view.addSubview(segmentedControl)
        view.addSubview(exercisesLabel)
        view.addSubview(tableView)
    }
    
    @objc private func segmentedChange() {
        print("tap segmented")
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
            
            exercisesLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            exercisesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            exercisesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: exercisesLabel.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)

        ])
    }
}
