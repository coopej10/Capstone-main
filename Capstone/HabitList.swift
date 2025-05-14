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
        ZStack {
            Color(red: 255/255, green: 179/255, blue: 186/255)
            
            Text("Current Habits")
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(Color.white)
                .padding()
        }
        .frame(width: 250, height: 100)
        .cornerRadius(20)
        .padding()
        
        ZStack {
            Color(red: 186/255, green: 225/255, blue: 255/255)
            
            Text("Your future is built daily")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color.black)
        }
        .frame(width: 350, height: 75)
        .cornerRadius(15)
        
        ZStack{
            if habits.isEmpty {
                ZStack {
                    Color(red: 255/255, green: 255/255, blue: 186/255)
                    
                    Text("No habits yet! Add some to start tracking.")
                        .font(.headline)
                        .fontWeight(.medium)
                }
                .frame(maxWidth: .infinity)
                .cornerRadius(15)
                
            } else {
                List {
                    ForEach (habits) { habit in
                        Text(habit.habit)}
                    .onDelete(perform: deleteHabit)
                }
            .listStyle(.plain)
            }
        }
    .padding()
    Spacer()
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
