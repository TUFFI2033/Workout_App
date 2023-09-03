//
//  ViewController.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 01/09/2023.
//

import UIKit

class ViewController: UIViewController {

    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.7607843137, blue: 0.7607843137, alpha: 1)
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ivan Byndiu"
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3176470588, blue: 0.3137254902, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addWorkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.8392156863, blue: 0.3568627451, alpha: 1)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowRadius = 4
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.setTitle("Add workout", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.tintColor = #colorLiteral(red: 0.1411764706, green: 0.2941176471, blue: 0.262745098, alpha: 1)
        button.imageEdgeInsets = .init(top: 0, left: 20, bottom: 15, right: 0)
        button.titleEdgeInsets = .init(top: 50, left: -40, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(addWorkoutButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let calendarView = CalendarView()
    
    private let weathetView = WeatherView()
    
    override func viewDidLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }

// MARK: Private Func
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9294117647, blue: 0.8862745098, alpha: 1)
        
        view.addSubview(calendarView)
        view.addSubview(userPhotoImageView)
        view.addSubview(userNameLabel)
        view.addSubview(addWorkoutButton)
        view.addSubview(weathetView)
    }
    
    @objc private func addWorkoutButtonTapped() {
        print("Tap")
    }

}

// MARK: Set Constraints

extension ViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userPhotoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            calendarView.topAnchor.constraint(equalTo: userPhotoImageView.centerYAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 70),
            
            userNameLabel.bottomAnchor.constraint(equalTo: calendarView.topAnchor, constant: -10),
            userNameLabel.leadingAnchor.constraint(equalTo: userPhotoImageView.trailingAnchor, constant: 15),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            addWorkoutButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 5),
            addWorkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addWorkoutButton.heightAnchor.constraint(equalToConstant: 80),
            addWorkoutButton.widthAnchor.constraint(equalToConstant: 80),
            
            weathetView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 5),
            weathetView.leadingAnchor.constraint(equalTo: addWorkoutButton.trailingAnchor, constant: 10),
            weathetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            weathetView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
