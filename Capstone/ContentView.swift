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
        NavigationStack {
            VStack(spacing: 16) {
                // Header
                HStack {
                    Text("Add a habit")
                        .font(.system(size: 20))
                        .fontWeight(.black)
                    
                    Spacer()
                    
                    Button {
                        showNewHabit = true
                    } label: {
                        Text("+")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
                .padding(.horizontal)
                
        // Show New Habit View
                if showNewHabit {
                    NewHabitView { habitName, endDate, repeatsForever in
                        print("Habit: \(habitName), End: \(String(describing: endDate)), Repeat: \(repeatsForever)")
                        showNewHabit = false
                    }
                    .padding(.horizontal)
                }
        
    // Scrollable content
        ScrollView(.vertical, showsIndicators: true) {
            VStack{
                        
            ZStack {
                Color(red: 255/255, green: 179/255, blue: 186/255)
                            
                Text("A better you, on repeat.")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                        }
                    .frame(width: 250, height: 100)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .shadow(radius: 6)
                        
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .padding(.horizontal)
                        
                    LazyVStack {
                        ForEach(habits.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }) { habit in
                        HStack {
                            Text(habit.habit)
                            Spacer()
                            Button {
                                toggleCompletion(for: habit)
                            } label: {
                                Image(systemName: habit.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(habit.isCompleted ? .green : .gray)
                                    }
                                .buttonStyle(.plain)
                                }
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                            }
                            .onDelete(perform: deleteHabit)
                        }
                        .padding(.horizontal)
                        
                    NavigationLink(destination: HabitList()) {
                        VStack {
                            Text("View All Habits")
                                .multilineTextAlignment(.center)
                            Image("logo")
                                .resizable()
                                .frame(width: 150, height: 150)
                            }
                        }
                        .padding()
                    }
                }
            }
            .padding()
        }
    }

    // Functions

    func deleteHabit(at offsets: IndexSet) {
        for offset in offsets {
            let habit = habits[offset]
            modelContext.delete(habit)
        }
    }
    
    func toggleCompletion(for habit: HabitItem) {
        habit.isCompleted.toggle()
        try? modelContext.save()
    }
}

#Preview {
    ContentView()
}
