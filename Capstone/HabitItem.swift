//
//  HabitItem.swift
//  Capstone
//
//  Created by Jessica Cooper on 5/11/25.
//

import Foundation
import SwiftData

@Model
class HabitItem: Identifiable {
    var id = UUID()
    var habit: String
    var date: Date
    var isCompleted: Bool
    
    init(habit: String, date: Date, isCompleted: Bool = false) {
            self.habit = habit
            self.date = Calendar.current.startOfDay(for: date)
            self.isCompleted = isCompleted
    }
    
}

