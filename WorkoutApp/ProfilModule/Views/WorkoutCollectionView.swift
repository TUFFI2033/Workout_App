//
//  WorkoutCollectionView.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 05/11/2023.
//

import UIKit

class WorkoutCollectionView: UICollectionView {
    
    var resultArray = [ResultWorkout]()
    private let idWorkoutCell = "idWorkoutCell"
    private let collectionLayout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionLayout)
        
        register(WorkoutCollectionViewCell.self, forCellWithReuseIdentifier: idWorkoutCell)
        setupLayout()
        configure()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        collectionLayout.minimumInteritemSpacing = 5
        collectionLayout.scrollDirection = .horizontal
    }
    
    private func configure() {
        clipsToBounds = false
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
    }
    
    private func setDelegate() {
        dataSource = self
        delegate = self
    }
}

//MARK: - UICollectionViewDataSource

extension WorkoutCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        resultArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: idWorkoutCell, for: indexPath) as? WorkoutCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.row % 4 == 0 || indexPath.row % 4 == 3  {
            cell.backgroundColor = .specialGreen
        } else {
            cell.backgroundColor = .specialYellow
        }
        
        let model = resultArray[indexPath.row]
        cell.configure(model: model)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension WorkoutCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 2.07,
               height: 120)
    }
}
