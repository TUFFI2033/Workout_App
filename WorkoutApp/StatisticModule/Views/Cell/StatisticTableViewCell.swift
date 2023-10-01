//
//  StatisticTableViewCell.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 27/09/2023.
//

import UIKit

class StatisticTableViewCell: UITableViewCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Biceps"
        label.textColor = .specialGray
        label.font = .robotoBold24()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let differenceLabel: UILabel = {
        let label = UILabel()
        label.text = "+2"
        label.textColor = .specialGreen
        label.font = .robotoBold24()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let beforeLabel = UILabel(text: "Before: 18")
    private let nowLabel = UILabel(text: "Now: 20")
    
    private lazy var repsSetsStackView = UIStackView(arrangedSubviews: [beforeLabel, nowLabel],
                                                     axis: .horizontal,
                                                     spacing: 10)
    private lazy var labelsStackView = UIStackView(arrangedSubviews: [nameLabel, repsSetsStackView],
                                                   axis: .vertical,
                                                   spacing: 2)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        repsSetsStackView.distribution = .fillEqually
        addSubview(nameLabel)
        addSubview(differenceLabel)
        addSubview(labelsStackView)
    }
}

//MARK: - Set Constraints

extension StatisticTableViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            differenceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            differenceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            differenceLabel.widthAnchor.constraint(equalToConstant: 60),
            
            labelsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            labelsStackView.trailingAnchor.constraint(lessThanOrEqualTo: differenceLabel.leadingAnchor, constant: -10),
        ])
    }
}
