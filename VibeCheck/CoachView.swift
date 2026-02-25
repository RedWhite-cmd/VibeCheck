//
//  CoachView.swift
//  VibeCheck
//
//  Created by Sudeep Thatiparthi on 2/24/26.
//


import SwiftUI

struct CoachView: View {
    @EnvironmentObject var healthManager: HealthManager
    @EnvironmentObject var taskManager: TaskManager

    private let engine = CoachEngine()
    @State private var showBreathing = false

    var finalSafetyScore: Int {
        100 + healthManager.exercisePoints - healthManager.stressPenalty - taskManager.taskPenalty
    }

    var body: some View {
        let suggestion = engine.suggestion(
            score: finalSafetyScore,
            hrvLow: healthManager.stressPenalty > 0,
            taskPenalty: taskManager.taskPenalty
        )

        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("VibeCoach")
                    .font(.largeTitle).bold()

                VStack(alignment: .leading, spacing: 8) {
                    Text(suggestion.title)
                        .font(.title3).bold()
                    Text(suggestion.reason)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(.thinMaterial)
                .cornerRadius(12)

                Text("Try these now")
                    .font(.headline)

                ForEach(suggestion.actions, id: \.self) { action in
                    Label(action, systemImage: "sparkle")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                }

                Button {
                    showBreathing = true
                } label: {
                    Label("Start 1-minute Breathing", systemImage: "lungs.fill")
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 8)
            }
            .padding()
        }
        .sheet(isPresented: $showBreathing) {
            BreathingExerciseView(durationSeconds: 60)
        }
    }
}