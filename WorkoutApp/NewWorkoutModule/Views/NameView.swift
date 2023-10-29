//
//  NameView.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 01/10/2023.
//

import UIKit

class NameView: UIView {
    
    private let nameLable = UILabel(text: "Name")
    private let nameTextField = BrownTextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(nameLable)
        addSubview(nameTextField)
    }
    
    func getNameFieldText() -> String {
        guard let text = nameTextField.text else { return "" }
        return text 
    }
    
    func deleteTextFild() {
        nameTextField.text = ""
    }
}

// MARK: Set Constraints

extension NameView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameLable.topAnchor.constraint(equalTo: topAnchor),
            nameLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            nameLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            nameLable.heightAnchor.constraint(equalToConstant: 16), 
            
            nameTextField.topAnchor.constraint(equalTo: nameLable.bottomAnchor, constant: 3),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
