//
//  CapstoneApp.swift
//  Capstone
//
//  Created by Jessica Cooper on 5/11/25.
//

import SwiftUI
import SwiftData

@main
struct CapstoneApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: HabitItem.self)
        }
    }
}
