//
//  ContentView.swift
//  VibeCheck
//
//  Created by Sudeep Thatiparthi on 2/4/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var healthManager: HealthManager
    @EnvironmentObject var taskManager: TaskManager
    @EnvironmentObject var pulseScanner: HeartRateScanner
    
    @State private var isScanning = false

    var finalSafetyScore: Int {
        return 100 + healthManager.exercisePoints - healthManager.stressPenalty - taskManager.taskPenalty
    }

    // Recommendation logic
    var safetyMessage: String {
        if finalSafetyScore > 80 { return "You're in the green! Keep it up." }
        else if finalSafetyScore > 50 { return "Feeling the pressure? Take a short walk." }
        else { return "High stress detected. Time to decompress." }
    }

    var body: some View {
        VStack(spacing: 30) {
            Text("VibeCheck Safety Score")
                .font(.title2).fontWeight(.bold)

            
            ZStack {
                Circle()
                    .stroke(lineWidth: 20).opacity(0.1).foregroundColor(.blue)
                
                // Animated ring that reflects the score
                Circle()
                    .trim(from: 0, to: CGFloat(min(max(Double(finalSafetyScore) / 100.0, 0), 1)))
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                    .foregroundColor(finalSafetyScore > 60 ? .blue : .red)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut, value: finalSafetyScore)

                VStack {
                    Text("\(finalSafetyScore)")
                        .font(.system(size: 60, weight: .bold))
                    Text("Points")
                        .foregroundColor(.secondary)
                }
            }
            .frame(width: 200, height: 200)

            
            Text(safetyMessage)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .foregroundColor(.secondary)

           
            VStack(alignment: .leading, spacing: 15) {
                Label("Exercise: +\(healthManager.exercisePoints)", systemImage: "bolt.fill").foregroundColor(.green)
                Label("Bio-Stress: -\(healthManager.stressPenalty)", systemImage: "heart.break.fill").foregroundColor(.red)
                Label("Workload: -\(taskManager.taskPenalty)", systemImage: "list.bullet.clipboard.fill").foregroundColor(.orange)
            }
            .padding().frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.secondarySystemBackground)).cornerRadius(15)

            // Inline Scan section on the dashboard
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Label("Manual Scan", systemImage: "waveform.path.ecg")
                        .font(.headline)
                    Spacer()
                    Circle()
                        .fill(isScanning ? Color.red : Color.gray.opacity(0.4))
                        .frame(width: 10, height: 10)
                        .accessibilityLabel(isScanning ? "Scanning active" : "Scanning inactive")
                }

                Text("BPM: \(pulseScanner.bpm)")
                    .font(.title2).bold()

                HStack(spacing: 12) {
                    Button(isScanning ? "Stop" : "Start") {
                        if isScanning {
                            pulseScanner.stopCapture()
                            isScanning = false
                        } else {
                            pulseScanner.startCapture()
                            isScanning = true
                        }
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Sync Now") {
                        // Optional quick sync alongside scanning controls
                        healthManager.requestAuthorization()
                        healthManager.fetchLatestHRV()
                        taskManager.fetchTaskLoad()
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(15)
            
            HStack(spacing: 20) {
                Button("Sync") {
                    healthManager.requestAuthorization()
                    healthManager.fetchLatestHRV()
                    taskManager.fetchTaskLoad()
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
    }
}

