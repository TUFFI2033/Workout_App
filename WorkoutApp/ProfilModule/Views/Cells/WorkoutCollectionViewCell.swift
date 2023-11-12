//
//  WorkoutCollectionViewCell.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 05/11/2023.
//

import UIKit

class WorkoutCollectionViewCell: UICollectionViewCell {
    
    private let workoutNameLabel = UILabel(text: "",
                                           font: .robotoBold24(),
                                           textColor: .white)
    private let workoutCountLabel = UILabel(text: "",
                                            font: .robotoBold48(),
                                            textColor: .white)
    
    private let workoutImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "testWorkout")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var stackCountLabelAndImage = UIStackView(
        arrangedSubviews: [workoutImage, workoutCountLabel],
        axis: .horizontal,
        spacing: 5)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layer.cornerRadius = 20
        
        workoutNameLabel.textAlignment = .center
        stackCountLabelAndImage.distribution = .equalSpacing
        
        addSubview(workoutNameLabel)
        addSubview(stackCountLabelAndImage)
    }
    
    func configure(model: ResultWorkout) {
        workoutNameLabel.text = model.name
        workoutCountLabel.text = "\(model.result)"
        
        guard let data = model.imageData else { return }
        let image = UIImage(data: data)
        workoutImage.image = image
    }
}

// MARK: Set Constraints

extension WorkoutCollectionViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            workoutNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            workoutNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            workoutNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            workoutImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            workoutImage.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            stackCountLabelAndImage.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor, constant: 10),
            stackCountLabelAndImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackCountLabelAndImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackCountLabelAndImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
