//
//  ContentView.swift
//  Capstone
//
//  Created by Jessica Cooper on 5/11/25.
//

//FINAL VERSION

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showNewHabit = false
    @Query var habits: [HabitItem]
    @Environment(\.modelContext) var modelContext
    
    @State private var selectedDate = Date()
    
    var body: some View {
        
        HStack {
            Text("Add a habit")
                .font(.system(size: 20))
                .fontWeight(.black)
            
            Button {
                showNewHabit = true
            } label: {
                Text("+")
                    .font(.title)
                    .fontWeight(.bold)
            }
            Spacer()
        }
        .padding()
        
        if showNewHabit {
            NewHabitView { habitName, endDate, repeatsForever in
                print("Habit: \(habitName), End: \(String(describing: endDate)), Repeat: \(repeatsForever)")
                showNewHabit = false
            }
        }
                
               
        NavigationStack {
            VStack {
                ZStack {
                    Color(.systemPink)
                    
                    Text("Every day counts! Track your habits.")
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                }
                .frame(width: 250, height: 100)
                .cornerRadius(20)
                
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding()
                
                List {
                    ForEach(habits.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }) { habit in
                        HStack {
                            Text(habit.habit)
                            Spacer()
                            if habit.isCompleted {
                                Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                            } else {
                                Image(systemName: "circle").foregroundColor(.gray)
                            }
                        }
                    }
                    .onDelete(perform: deleteHabit)
                }
                
                NavigationLink(destination: HabitList()) {
                    Text("View All Habits")
                }

            }
        }
            .padding()
        }
    func deleteHabit(at offsets: IndexSet) {
        for offset in offsets {
            let habit = habits[offset]
            modelContext.delete(habit)
            }
        }
    }
    #Preview {
            ContentView()
    }
