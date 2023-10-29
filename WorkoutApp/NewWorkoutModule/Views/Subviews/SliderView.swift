//
//  SliderView.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 01/10/2023.
//

import UIKit

protocol SlidetViewProtocol: AnyObject {
    func changeValue(type: SliderType, value: Int)
}

class SliderView: UIView {
    
    weak var delegate: SlidetViewProtocol?
    
    private let nameLabel = UILabel(text: "Name", font: .robotoMedium18(), textColor: .specialGray)
    private let numberLabel = UILabel(text: "0", font: .robotoMedium24(), textColor: .specialGray)
    private let slider = GreenSlider()
    
    private lazy var labelStackView = UIStackView(arrangedSubviews: [nameLabel,numberLabel],
                                             axis: .horizontal,
                                             spacing: 10) 
    private lazy var unitStackView = UIStackView(arrangedSubviews: [labelStackView, slider],
                                             axis: .vertical,
                                             spacing: 10)
    
    private var sliderType: SliderType?
    
    var isActive: Bool = true {
        didSet {
            if self.isActive {
                unitStackView.alpha = 1
            } else {
                unitStackView.alpha = 0.5
                slider.value = 0
                numberLabel.text = "0"
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(name: String, maxValue: Float, type: SliderType) {
        self.init()
        self.nameLabel.text = name
        self.slider.minimumValue = 0
        self.slider.maximumValue = maxValue
        self.sliderType = type
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        
        slider.addTarget(self, action: #selector(sliderChange), for: .valueChanged)
        
        labelStackView.distribution = .equalSpacing
        
        addSubview(unitStackView)
    }
    
    @objc private func sliderChange() {
        let intSliderValue = Int(slider.value)
        numberLabel.text =  sliderType == .timer ? intSliderValue.getTimeFromSeconds() : "\(intSliderValue)"
        guard let sliderType else { return }
        delegate?.changeValue(type: sliderType, value: intSliderValue)
    }
    
    func resetValues() {
        numberLabel.text = "0"
        slider.value = 0
        isActive = true
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
