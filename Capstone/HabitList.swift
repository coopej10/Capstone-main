//
//  HabitList.swift
//  Capstone
//
//  Created by Jessica Cooper on 5/12/25.
//

import SwiftUI
import SwiftData

struct HabitList: View {
    @Query var habits: [HabitItem]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack {
            Text("Current Habits:")
                .font(.title)
                .fontWeight(.medium)
                .padding()
            
            List {
                ForEach (habits) { habit in
                    Text(habit.habit)}
                .onDelete(perform: deleteHabit)
            }
        }
    }
    
    func deleteHabit(at offsets: IndexSet) {
        for offset in offsets {
            let habit = habits[offset]
            modelContext.delete(habit)
            }
        }
}
#Preview {
  HabitList()
}
