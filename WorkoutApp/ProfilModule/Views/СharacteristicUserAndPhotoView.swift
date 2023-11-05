//
//  СharacteristicUserAndPhotoView.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 05/11/2023.
//

import UIKit

class СharacteristicUserAndPhotoView: UIView {
    
    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .specialLine
        imageView.image = UIImage(named: "addPhoto")
        imageView.contentMode = .center
        imageView.layer.cornerRadius = 50
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var editingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Editing", for: .normal)
        button.setTitleColor(.specialGreen, for: .normal)
        button.setImage(UIImage(named: "profileEditing"), for: .normal)
        button.titleLabel?.font = .robotoMedium16()
        button.backgroundColor = .clear
        button.semanticContentAttribute = .forceRightToLeft
        button.titleEdgeInsets = .init(top: 0, left: -10, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(editingButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private let greenView = UIView()
    private let nameUserLabel = UILabel(text: "User Name",
                                        font: .robotoBold24(),
                                        textColor: .white)
    private let userHeightLabel = UILabel(text: "Height: 180",
                                     font: .robotoBold16(),
                                     textColor: .specialGray)
    private let userWeightLabel = UILabel(text: "Weight: 80",
                                     font: .robotoBold16(),
                                     textColor: .specialGray)
    private lazy var stackUserHeightWeightLabel = UIStackView(arrangedSubviews: [userHeightLabel, userWeightLabel], axis: .horizontal, spacing: 10)
    private lazy var stackUserLabelAndEditing = UIStackView(arrangedSubviews: [stackUserHeightWeightLabel, editingButton], axis: .horizontal, spacing: 20)
    
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
        backgroundColor = .clear
        
        greenView.translatesAutoresizingMaskIntoConstraints = false
        greenView.backgroundColor = .specialGreen
        greenView.layer.cornerRadius = 10
        
        nameUserLabel.textAlignment = .center
        
        stackUserLabelAndEditing.distribution = .equalSpacing
    
        addSubview(greenView)
        addSubview(userPhotoImageView)
        addSubview(nameUserLabel)
        addSubview(stackUserLabelAndEditing)
    }
    
    @objc private func editingButtonTapped() {
        
    }
}

// MARK: Set Constraints

extension СharacteristicUserAndPhotoView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: topAnchor),
            userPhotoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            greenView.leadingAnchor.constraint(equalTo: leadingAnchor),
            greenView.trailingAnchor.constraint(equalTo: trailingAnchor),
            greenView.topAnchor.constraint(equalTo: userPhotoImageView.centerYAnchor),
            greenView.heightAnchor.constraint(equalToConstant: 110),
            
            nameUserLabel.leadingAnchor.constraint(equalTo: greenView.leadingAnchor, constant: 20),
            nameUserLabel.trailingAnchor.constraint(equalTo: greenView.trailingAnchor, constant: -20),
            nameUserLabel.topAnchor.constraint(equalTo: userPhotoImageView.bottomAnchor, constant: 20),
            
            stackUserLabelAndEditing.topAnchor.constraint(equalTo: greenView.bottomAnchor, constant: 10),
            stackUserLabelAndEditing.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackUserLabelAndEditing.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
