//
//  Int + Extension.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 04/10/2023.
//

import UIKit

extension Int {
    
    func getTimeFromSeconds() -> String {
        
        if self / 60 == 0 {
            return "\(self % 60) sec"
        } 
        
        if self % 60 == 0 {
            return "\(self / 60) min"
        }
        return "\(self / 60) min \(self % 60)"
    }
}
