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
        label.text = "Солнечно"
        label.textColor = #colorLiteral(red: 0.3913812339, green: 0.3912524879, blue: 0.3872336149, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Хорошая погода, чтобы позаниматься на улице"
        label.textColor = #colorLiteral(red: 0.7607843137, green: 0.7607843137, blue: 0.7607843137, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = #colorLiteral(red: 0.9813271165, green: 0.9813271165, blue: 0.9813271165, alpha: 1)
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 4
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(weatherLabel)
        addSubview(weatherDescriptionLabel)
        addSubview(weatherImage)
    }
    
}

//  MARK: Set Constraints

extension WeatherView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            weatherLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            weatherLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            weatherLabel.trailingAnchor.constraint(equalTo: weatherImage.leadingAnchor, constant: -20),
            
            weatherDescriptionLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 5),
            weatherDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            weatherDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            weatherDescriptionLabel.trailingAnchor.constraint(equalTo: weatherImage.leadingAnchor, constant: -20),
            
            weatherImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            weatherImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            weatherImage.heightAnchor.constraint(equalToConstant: 62),
            weatherImage.widthAnchor.constraint(equalToConstant: 62)
        ])
    }
}
