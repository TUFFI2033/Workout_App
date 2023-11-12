//
//  WeatherView.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 02/09/2023.
//

import UIKit

class WeatherView: UIView {
    
    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .specialGray
        label.text = "Loading..."
        label.font = .robotoMedium18()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .specialLine
        label.font = .robotoMedium14()
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "sun")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
        
        addShadowOnView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(weatherLabel)
        addSubview(weatherDescriptionLabel)
        addSubview(weatherImage)
    }
    
    func updateImage(data: Data) {
        guard let image = UIImage(data: data) else { return }
        weatherImage.image = image
    }
    
    func updateLabels(model: WeatherModel) {
        weatherLabel.text = model.name + " " + "\(model.main.temperatureCelsius)°C"
        weatherDescriptionLabel.text = model.weather[0].description.prefix(1).capitalized +
        model.weather[0].description.dropFirst()
    }
}

//  MARK: Set Constraints

extension WeatherView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            weatherLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            weatherLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            weatherLabel.trailingAnchor.constraint(equalTo: weatherImage.leadingAnchor, constant: -20),
            weatherLabel.heightAnchor.constraint(equalToConstant: 20),
            
            weatherDescriptionLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 5),
            weatherDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            weatherDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            weatherDescriptionLabel.trailingAnchor.constraint(equalTo: weatherImage.leadingAnchor, constant: -20),
            
            weatherImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            weatherImage.heightAnchor.constraint(equalToConstant: 60),
            weatherImage.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}
