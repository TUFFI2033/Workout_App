//
//  StartWorkoutViewController.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 29/10/2023.
//

import UIKit

class StartWorkoutViewController: UIViewController {
    
    private let startWorloutLabel: UILabel = {
        let label = UILabel()
        label.text = "START WORKOUT"
        label.textColor = .specialGray
        label.font = .robotoBold24()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.isHidden = true
        label.textColor = .specialGray
        label.font = .robotoBold48()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageOrTimerImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "sportsman")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.text = "Details"
        label.textColor = .specialBrown
        label.font = .robotoMedium14()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let customAlert = CustomAlert()
    private let closeButton = CloseButton()
    private let setsRepsView = SetsRepsView()
    private let finishButton = GreenButton(text: "FINISH")
    private var workoutModel = WorkoutModel()
    private var numberOfSet = 1
    private var durationTimer = 10
    private var timer = Timer()
    private var shapeLayer = CAShapeLayer()
    
    override func viewDidLayoutSubviews() {
        animationCircular()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        addGesture()
        setWorkoutParameters()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        finishButton.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
        setsRepsView.refreshLabels(model: workoutModel, numberOfSet: numberOfSet)
        setsRepsView.cellNextSetDelegate = self
        
        view.addSubview(startWorloutLabel)
        view.addSubview(timerLabel)
        view.addSubview(imageOrTimerImageView)
        view.addSubview(closeButton)
        view.addSubview(detailsLabel)
        view.addSubview(setsRepsView)
        view.addSubview(finishButton)
    }
    
    @objc private func closeButtonTapped() {
        timer.invalidate()
        dismiss(animated: true)
    }
    
    @objc private func finishButtonTapped() {
        if numberOfSet == workoutModel.workoutSets {
            RealmManager.shared.updateStatusWorkoutModel(workoutModel)
            dismiss(animated: true)
        } else {
            presentAlertWithAction(title: "Warning", message: "You haven't finished your workout") {
                self.dismiss(animated: true)
            }
        }
    }
    
    private func addGesture() {
        let tapLabel = UITapGestureRecognizer(target: self, action: #selector(startTimer))
        timerLabel.isUserInteractionEnabled = true
        timerLabel.addGestureRecognizer(tapLabel)
    }
    
    @objc private func startTimer() {
        setsRepsView.buttonsIsEnable(false)
        
        if numberOfSet == workoutModel.workoutSets {
            presentSimpleAlert(title: "Error", message: "Finsh your workout")
        } else {
            basicAnimation()
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(timerAction),
                                         userInfo: nil,
                                         repeats: true)
        }
    }
    
    private func setWorkoutParameters() {
        let (min, sec) = workoutModel.workoutTimer.convertSeconds()
        timerLabel.text = "\(min):\(sec.setZeroForSecond())"
        durationTimer = workoutModel.workoutTimer
    }
    
    @objc private func timerAction() {
        durationTimer -= 1
        print(durationTimer)
        
        if durationTimer == 0 {
            timer.invalidate()
            durationTimer = workoutModel.workoutTimer
            
            numberOfSet += 1
            setsRepsView.refreshLabels(model: workoutModel, numberOfSet: numberOfSet)
            setsRepsView.buttonsIsEnable(true)
        }
        
        let (min, sec) = durationTimer.convertSeconds()
        timerLabel.text = "\(min):\(sec.setZeroForSecond())"
    }
    
    func setWorkoutModel(_ model: WorkoutModel) {
        workoutModel = model
    }    
    
    func updateImageAndTimer(image: String) {
        imageOrTimerImageView.image = UIImage(named: image)
        timerLabel.isHidden = false
    }
}

// MARK: Set Constraints

extension StartWorkoutViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            startWorloutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            startWorloutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            timerLabel.centerXAnchor.constraint(equalTo: imageOrTimerImageView.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: imageOrTimerImageView.centerYAnchor),
            
            imageOrTimerImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageOrTimerImageView.topAnchor.constraint(equalTo: startWorloutLabel.bottomAnchor, constant: 20),
            imageOrTimerImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            imageOrTimerImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            
            detailsLabel.leadingAnchor.constraint(equalTo: setsRepsView.leadingAnchor, constant: 10),
            detailsLabel.topAnchor.constraint(equalTo: imageOrTimerImageView.bottomAnchor, constant: 30),
            
            setsRepsView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 5),
            setsRepsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            setsRepsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            setsRepsView.heightAnchor.constraint(equalToConstant: 240),
            
            finishButton.topAnchor.constraint(equalTo: setsRepsView.bottomAnchor, constant: 20),
            finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}

// MARK: NextSetProtocol

extension StartWorkoutViewController: NextSetProtocol {
    func nextSetTapped() {
        if numberOfSet < workoutModel.workoutSets {
            numberOfSet += 1
            setsRepsView.refreshLabels(model: workoutModel, numberOfSet: numberOfSet)
        } else {
            presentSimpleAlert(title: "Finish", message: "Finish your workout")
        }
    }
    
    func editingTapped() {
        if workoutModel.workoutReps != 0 {
            customAlert.presentCustomAlert(viewController: self,
                                           repsOrTimer: "Reps") { [weak self] sets, reps in
                guard let self else { return }
                
                if sets != "" && reps != "" {
                    guard let numberOfSets = Int(sets),
                          let numberOfReps = Int(reps) else { return }
                    RealmManager.shared.updateSetsRepsWorkoutModel(model: self.workoutModel,
                                                                   sets: numberOfSets,
                                                                   reps: numberOfReps)
                    self.setsRepsView.refreshLabels(model: self.workoutModel, numberOfSet: self.numberOfSet)
                }
            }
        } else {
            customAlert.presentCustomAlert(viewController: self,
                                           repsOrTimer: "Time Of Set") { [weak self] sets, time in
                guard let self else { return }
                
                if sets != "" && time != "" {
                    guard let numberOfSets = Int(sets),
                          let numberOftime = Int(time) else { return }
                    RealmManager.shared.updateSetsTimerWorkoutModel(model: self.workoutModel, sets: numberOfSets, timer: numberOftime)
                    self.setsRepsView.refreshLabels(model: self.workoutModel, numberOfSet: self.numberOfSet)
                    setWorkoutParameters()
                }
            }
        }
    }
}

//MARK: - Animation

extension StartWorkoutViewController {
    
    private func animationCircular() {
        if workoutModel.workoutTimer != 0 {
            let center = CGPoint(x: imageOrTimerImageView.frame.width / 2,
                                 y: imageOrTimerImageView.frame.height / 2)
            
            let endAngle = 3 * CGFloat.pi / 2
            let startAngle = CGFloat.pi * 2 + endAngle
            
            let circularPath = UIBezierPath(arcCenter: center,
                                            radius: imageOrTimerImageView.frame.height / 2.2,
                                            startAngle: startAngle,
                                            endAngle: endAngle,
                                            clockwise: false)
            
            shapeLayer.path = circularPath.cgPath
            shapeLayer.lineWidth = 22
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = UIColor.specialGreen.cgColor
            shapeLayer.lineCap = .round
            imageOrTimerImageView.layer.addSublayer(shapeLayer)
        }
    }
    
    private func basicAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(durationTimer)
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
}
