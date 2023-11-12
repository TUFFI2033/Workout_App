//
//  Date + Extensions.swift
//  WorkoutApp
//
//  Created by Ivan Byndiu on 14/10/2023.
//

import Foundation

extension Date {
    
    func getWeekdayNumber() -> Int {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: self)
        return weekday
    }
    
    func localDate() -> Date{
        let timeZoneOffset = TimeZone.current.secondsFromGMT(for: self)
        let localDate = Calendar.current.date(byAdding: .second, value: timeZoneOffset, to: self) ?? Date()
        
        return localDate
    }
    
    func getWeekArray() -> [[String]] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.dateFormat = "EEEEEE"
        let calendar = Calendar.current
        
        var weekArray: [[String]] = [[], []]
        
        for index in 0...6 {
            let date = calendar.date(byAdding: .day, value: index, to: self) ?? Date()
            let day = calendar.component(.day, from: date)
            weekArray[1].append("\(day)")
            let weekday = formatter.string(from: date)
            weekArray[0].append(weekday)
        }
        
        return weekArray
    }
    
    func offsetDay(days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: self) ?? Date()
    }    
    
    func offsetMonth(month: Int) -> Date {
        Calendar.current.date(byAdding: .month, value: -month, to: self) ?? Date()
    }
    
    func startEndDate() -> (start: Date, end: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let calendar = Calendar.current
        
        let stringDate = formatter.string(from: self)
        let totalDate = formatter.date(from: stringDate) ?? Date()
        
        let local = totalDate.localDate()
        let dateEnd: Date = {
            let components = DateComponents(day: 1)
            return calendar.date(byAdding: components, to: local) ?? Date()
        }()
        
        return (local, dateEnd)
    }
}
