//
//  Ext+Date.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 05/11/25.
//

import Foundation



extension Date {
    func startOfWeek(using calendar: Calendar = .gregorian) -> Date {
        calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!
    }
}

func getWeekDates(for date: Date, using calendar: Calendar = .gregorian) -> [Date] {
    let start = date.startOfWeek(using: calendar) 
    return (0..<7).compactMap { offset in
        calendar.date(byAdding: .day, value: offset, to: start)
    }
}

