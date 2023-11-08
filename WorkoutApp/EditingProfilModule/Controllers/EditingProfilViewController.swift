//
//  EditingProfilViewController.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 06/11/2023.
//

import UIKit
import RealmSwift
import PhotosUI

class EditingProfilViewController: UIViewController {
    
    private let usetPhotoView = UserPhotoView()
    private let textFieldEditingUserView = TextFieldEditingUserView()
    private let saveButton = GreenButton(text: "SAVE")
    private var userModel = UserModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        loadUserInfo()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        usetPhotoView.delegate = self
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        view.addSubview(usetPhotoView)
        view.addSubview(textFieldEditingUserView)
        view.addSubview(saveButton)
    }    
    
    private func setUserModel() {
        guard let firstName = textFieldEditingUserView.userFirstNameTextField.text,
              let secondName = textFieldEditingUserView.userSecondNameTextField.text,
              let height = textFieldEditingUserView.userHeightTextField.text,
              let weight = textFieldEditingUserView.userWeightTextField.text,
              let targed = textFieldEditingUserView.userTargetTextField.text,
              let intHeight = Int(height),
              let intWeight = Int(weight),
              let intTarged = Int(targed) else {
            return
        }
        
        userModel.userFirstName = firstName
        userModel.userSecondName = secondName
        userModel.userHeight = intHeight
        userModel.userWeight = intWeight
        userModel.userTarget = intTarged
        
        if usetPhotoView.userPhotoImageView.image == UIImage(named: "addPhoto") {
            userModel.userImage = nil
        } else {
            guard let image = usetPhotoView.userPhotoImageView.image else { return }
            let jpegDate = image.jpegData(compressionQuality: 1.0)
            userModel.userImage = jpegDate
        }
    }
    
    private func loadUserInfo() {
        let userArray = RealmManager.shared.getResultUserModel()
        
        if !userArray.isEmpty {
            textFieldEditingUserView.userFirstNameTextField.text = userArray[0].userFirstName
            textFieldEditingUserView.userSecondNameTextField.text = userArray[0].userSecondName
            textFieldEditingUserView.userHeightTextField.text = "\(userArray[0].userHeight)"
            textFieldEditingUserView.userWeightTextField.text = "\(userArray[0].userWeight)"
            textFieldEditingUserView.userTargetTextField.text = "\(userArray[0].userTarget)"
            
            guard let data = userArray[0].userImage,
                  let image = UIImage(data: data) else {
                return
            }
            usetPhotoView.userPhotoImageView.image = image
            usetPhotoView.userPhotoImageView.contentMode = .scaleAspectFill
        }
    }
    
    @objc private func saveButtonTapped() {
        setUserModel()
        
        let userArray = RealmManager.shared.getResultUserModel()
        
        if userArray.isEmpty {
            RealmManager.shared.saveUserModel(userModel)
        } else {
            RealmManager.shared.updateUserModel(model: userModel)
        }
        userModel = UserModel()
        dismiss(animated: true)
    }
    
    @objc private func userPhotoImageViewTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            alerPhotoOrCamera { [weak self] source in
                guard let self else { return }
                
                if #available(iOS 14.0, *) {
                    self.presentPHPicker()
                } else {
                    self.chooseImagePicker(source: source)
                }
            }
        }
    }
}

// MARK: UserPhotoViewDelegate

extension EditingProfilViewController: UserPhotoViewDelegate {
    func userPhotoImageViewTap() {
        alerPhotoOrCamera { [weak self] source in
            guard let self else { return }
            
            if #available(iOS 14.0, *) {
                self.presentPHPicker()
            } else {
                self.chooseImagePicker(source: source)
            }
        }
    }
    
    func closeButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate
   
extension EditingProfilViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func chooseImagePicker(source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = source
        present(imagePicker, animated: true)
    }
    
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        usetPhotoView.userPhotoImageView.image = image
        usetPhotoView.userPhotoImageView.contentMode = .scaleAspectFill
        dismiss(animated: true)
    }
}
@available(iOS 14.0, *)
extension EditingProfilViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else { return }
                DispatchQueue.main.async {
                    self.usetPhotoView.userPhotoImageView.image = image
                    self.usetPhotoView.userPhotoImageView.contentMode = .scaleAspectFill
                }
            }
        }
    }
    
    private func presentPHPicker() {
        var phPickerConfig = PHPickerConfiguration(photoLibrary: .shared())
        phPickerConfig.selectionLimit = 1
        phPickerConfig.filter = PHPickerFilter.any(of: [.images])
        
        let phPickerVC = PHPickerViewController(configuration: phPickerConfig)
        phPickerVC.delegate = self
        present(phPickerVC, animated: true)
    }
}

// MARK: Set Constraints

extension EditingProfilViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            usetPhotoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            usetPhotoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usetPhotoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usetPhotoView.heightAnchor.constraint(equalToConstant: 160),
            
            textFieldEditingUserView.topAnchor.constraint(equalTo: usetPhotoView.bottomAnchor, constant: 40),
            textFieldEditingUserView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textFieldEditingUserView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            saveButton.topAnchor.constraint(equalTo: textFieldEditingUserView.bottomAnchor, constant: 40),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
