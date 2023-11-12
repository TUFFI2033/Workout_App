//
//  UserPhotoView.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 06/11/2023.
//

import UIKit

protocol UserPhotoViewDelegate: AnyObject {
    func closeButtonTapped()
    func userPhotoImageViewTap()
}

class UserPhotoView: UIView {
    
    weak var delegate: UserPhotoViewDelegate?
    
    private let editingProfilLabel = UILabel(text: "EDITING PROFILE",
                                             font: .robotoBold24(),
                                             textColor: .specialGray)
    private let closeButton = CloseButton()
    
    lazy var userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .specialLine
        imageView.image = UIImage(named: "addPhoto")
        imageView.contentMode = .center
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 5
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(userPhotoImageViewTap))
    
    private let greenView = UIView()
    
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
        
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        greenView.translatesAutoresizingMaskIntoConstraints = false
        greenView.backgroundColor = .specialGreen
        greenView.layer.cornerRadius = 10
        
        addSubview(editingProfilLabel)
        addSubview(closeButton)
        addSubview(greenView)
        addSubview(userPhotoImageView)
    }
    
    @objc private func closeButtonTapped() {
        delegate?.closeButtonTapped()
    }

    @objc private func userPhotoImageViewTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            delegate?.userPhotoImageViewTap()
        }
    }
}

// MARK: Set Constraints

extension UserPhotoView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            editingProfilLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            editingProfilLabel.topAnchor.constraint(equalTo: topAnchor),
            
            closeButton.topAnchor.constraint(equalTo: topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            userPhotoImageView.topAnchor.constraint(equalTo: editingProfilLabel.bottomAnchor, constant: 20),
            userPhotoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            greenView.leadingAnchor.constraint(equalTo: leadingAnchor),
            greenView.trailingAnchor.constraint(equalTo: trailingAnchor),
            greenView.topAnchor.constraint(equalTo: userPhotoImageView.centerYAnchor),
            greenView.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
}
