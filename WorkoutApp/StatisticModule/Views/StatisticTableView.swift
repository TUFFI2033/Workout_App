//
//  StatisticTableView.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 27/09/2023.
//

import UIKit

class StatisticTableView: UITableView {
    
    private let idStatisticTableViewCell = "idStatisticTableViewCell"
    
    private var differenceArray = [DifferenceWorkout]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        configure()
        setDelegates()
        register(StatisticTableViewCell.self, forCellReuseIdentifier: idStatisticTableViewCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .none
        separatorInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setDelegates() {
        dataSource = self
        delegate = self
    }
    
    func setDifferenceArray(_ array: [DifferenceWorkout]) {
        differenceArray = array
    }
}

// MARK: - UITableViewDataSource

extension StatisticTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        differenceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idStatisticTableViewCell, for: indexPath) as? StatisticTableViewCell else {
            return UITableViewCell()
        }
        let model = differenceArray[indexPath.row]
        cell.configure(differenceModel: model)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension StatisticTableView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        55
    }
}
