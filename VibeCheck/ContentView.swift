//
//  ContentView.swift
//  VibeCheck
//
//  Created by Sudeep Thatiparthi on 2/4/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var healthManager = HealthManager()
    @StateObject var taskManager = TaskManager()
    
    var finalSafetyScore: Int {
        // Start at 100, add exercise, subtract stress and tasks
        return 100 + healthManager.exercisePoints - healthManager.stressPenalty - taskManager.taskPenalty
    }

    var body: some View {
        VStack(spacing: 30) {
            Text("VibeCheck Safety Score")
                .font(.title2)
                .fontWeight(.bold)

            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.1)
                    .foregroundColor(.blue)
                
                VStack {
                    Text("\(finalSafetyScore)")
                        .font(.system(size: 60, weight: .bold))
                    Text("Points")
                        .foregroundColor(.secondary)
                }
            }
            .frame(width: 200, height: 200)

            VStack(alignment: .leading, spacing: 15) {
                Label("Exercise: +\(healthManager.exercisePoints)", systemImage: "bolt.fill")
                    .foregroundColor(.green)
                
                Label("Bio-Stress: -\(healthManager.stressPenalty)", systemImage: "heart.break.fill")
                    .foregroundColor(.red)
                
                Label("Workload: -\(taskManager.taskPenalty)", systemImage: "list.bullet.clipboard.fill")
                    .foregroundColor(.orange)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(15)

            
            Button("Sync My Vibe") {
                healthManager.requestAuthorization()
                healthManager.fetchLatestHRV()
                taskManager.fetchTaskLoad()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding()
    }
}
