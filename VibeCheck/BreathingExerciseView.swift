//
//  BreathingExerciseView.swift
//  VibeCheck
//
//  Created by Sudeep Thatiparthi on 2/24/26.
//


import SwiftUI

struct BreathingExerciseView: View {
    let durationSeconds: Int

    @State private var phase: Int = 0 // 0: Inhale, 1: Hold, 2: Exhale, 3: Hold
    @State private var timeLeft: Int = 4
    @Environment(\.dismiss) private var dismiss

    let phases = [("Inhale", 4), ("Hold", 4), ("Exhale", 4), ("Hold", 4)]

    var body: some View {
        VStack(spacing: 20) {
            Text("Box Breathing")
                .font(.title2).bold()

            Text(phases[phase].0)
                .font(.largeTitle).bold()

            Text("\(timeLeft)s")
                .font(.system(size: 56, weight: .bold, design: .rounded))

            Circle()
                .trim(from: 0, to: CGFloat(1.0 - Double(timeLeft) / Double(phases[phase].1)))
                .stroke(phaseColor, style: StrokeStyle(lineWidth: 16, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .frame(width: 180, height: 180)
                .animation(.linear(duration: 0.9), value: timeLeft)

            Button("Done") { dismiss() }
                .buttonStyle(.bordered)
                .padding(.top)
        }
        .padding()
        .onAppear { start() }
    }

    private var phaseColor: Color {
        switch phase {
        case 0: return .green
        case 2: return .blue
        default: return .teal
        }
    }

    private func start() {
        var total = 0
        var currentPhase = 0
        var currentTime = phases[currentPhase].1
        timeLeft = currentTime

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            total += 1
            currentTime -= 1
            timeLeft = currentTime

            if currentTime == 0 {
                currentPhase = (currentPhase + 1) % phases.count
                phase = currentPhase
                currentTime = phases[currentPhase].1
                timeLeft = currentTime
            }

            if total >= durationSeconds {
                timer.invalidate()
                dismiss()
            }
        }
    }
}
