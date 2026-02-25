//
//  TasksView.swift
//  VibeCheck
//
//  Created by Sudeep Thatiparthi on 2/24/26.
//


import SwiftUI

struct TasksView: View {
    @EnvironmentObject var taskManager: TaskManager

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Tasks & Workload")
                .font(.largeTitle).bold()

            Text("Penalty: -\(taskManager.taskPenalty)")
                .foregroundColor(.orange)

            Button("Refresh Reminders") {
                taskManager.fetchTaskLoad()
            }
            .buttonStyle(.bordered)

            VStack(alignment: .leading, spacing: 8) {
                Text("Suggestions")
                    .font(.headline)
                Label("Complete one quick reminder", systemImage: "bolt.fill")
                Label("Snooze or reschedule non-urgent items", systemImage: "clock")
                Label("Plan a 25-minute focus session", systemImage: "timer")
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)

            Spacer()
        }
        .padding()
    }
}