//
//  NewHabitView.swift
//  Capstone
//
//  Created by Jessica Cooper on 5/11/25.
//

import SwiftUI
import SwiftData

struct NewHabitView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var habitName = ""
      @State private var repeatsIndefinitely = true
      @State private var endDate = Date()
      var onSave: (String, Date?, Bool) -> Void
    
    
    var body: some View {
        VStack {
            Text("New habit:")
                .font(.title2)
            
            TextField("Enter your new habit or goal", text: $habitName)
                .padding(.horizontal, 20)
                .frame(height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.gray.opacity(0.2)))
                .padding(.horizontal)
            
            Toggle("Save this habit for every day?", isOn: $repeatsIndefinitely)
                           .padding(.horizontal)
           
            if !repeatsIndefinitely {
                            DatePicker("End date", selection: $endDate, displayedComponents: .date)
                                .datePickerStyle(.compact)
                                .padding(.horizontal)
                        }
            
            Button {
                saveHabit()
            } label: {
                Text("Save")
            }
            .padding(.horizontal)

        }
    }
    func saveHabit() {
        let startDate = Calendar.current.startOfDay(for: Date())
        let finalDate = repeatsIndefinitely ? startDate : Calendar.current.startOfDay(for: endDate)

        var currentDate = startDate

        while currentDate <= finalDate {
            let habitTracked = HabitItem(habit: habitName, date: currentDate, isCompleted: false)

            modelContext.insert(habitTracked)

            if let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) {
                currentDate = nextDate
            } else {
                break
            }
        }
    onSave(habitName, repeatsIndefinitely ? nil : endDate, repeatsIndefinitely)

    }
}

#Preview {
    NewHabitView{_ , _,_  in}
}
