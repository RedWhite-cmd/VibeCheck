//
//  RootTabView.swift
//  VibeCheck
//
//  Created by Sudeep Thatiparthi on 2/24/26.
//


import SwiftUI

struct RootTabView: View {
    @StateObject var healthManager = HealthManager()
    @StateObject var taskManager = TaskManager()
    @StateObject var pulseScanner = HeartRateScanner()

    var body: some View {
        TabView {
            ContentView()
                .tabItem { Label("Home", systemImage: "gauge") }

            CoachView()
                .tabItem { Label("Coach", systemImage: "person.fill.questionmark") }

            InsightsView()
                .tabItem { Label("Insights", systemImage: "chart.xyaxis.line") }

            TasksView()
                .tabItem { Label("Tasks", systemImage: "checklist") }
        }
        .environmentObject(healthManager)
        .environmentObject(taskManager)
        .environmentObject(pulseScanner)
    }
}