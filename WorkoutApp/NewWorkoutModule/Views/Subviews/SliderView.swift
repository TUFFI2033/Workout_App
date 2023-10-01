//
//  SliderView.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 01/10/2023.
//

import UIKit

class SliderView: UIView {
    
    private let nameLabel = UILabel(text: "Name", font: .robotoMedium18(), textColor: .specialGray)
    private let numberLabel = UILabel(text: "0", font: .robotoMedium24(), textColor: .specialGray)
    private let slider = GreenSlider()
    
    private lazy var labelStackView = UIStackView(arrangedSubviews: [nameLabel,numberLabel],
                                             axis: .horizontal,
                                             spacing: 10) 
    private lazy var unitStackView = UIStackView(arrangedSubviews: [labelStackView, slider],
                                             axis: .vertical,
                                             spacing: 10)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(name: String, maxValue: Float) {
        self.init()
        self.nameLabel.text = name
        self.slider.minimumValue = 0
        self.slider.maximumValue = maxValue
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        
        slider.addTarget(self, action: #selector(sliderChange), for: .valueChanged)
        
        labelStackView.distribution = .equalSpacing
        
        addSubview(unitStackView)
    }
    
    @objc private func sliderChange() {
        
    }
}

//MARK: - Set Constraints

extension SliderView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            unitStackView.topAnchor.constraint(equalTo: topAnchor),
            unitStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            unitStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            unitStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
