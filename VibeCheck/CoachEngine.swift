import Foundation

struct CoachSuggestion {
    let title: String
    let reason: String
    let actions: [String]
}

struct CoachEngine {
    func suggestion(score: Int, hrvLow: Bool, taskPenalty: Int) -> CoachSuggestion {
        if score <= 50 {
            return CoachSuggestion(
                title: "Let’s reset your nervous system",
                reason: hrvLow ? "Low HRV suggests elevated stress." : "Score is low today.",
                actions: [
                    "Try 2 minutes of box breathing",
                    "Step outside for fresh air",
                    "Clear one small task"
                ]
            )
        } else if taskPenalty >= 20 {
            return CoachSuggestion(
                title: "Lighten your load",
                reason: "Workload is dragging your score down.",
                actions: [
                    "Pick 1 task to complete now",
                    "Snooze or reschedule non-urgent items",
                    "Plan a 25-minute focus session"
                ]
            )
        } else if score >= 80 {
            return CoachSuggestion(
                title: "You’re in the green",
                reason: "Great momentum — keep it up.",
                actions: [
                    "Maintain your routine",
                    "Add a 10-minute walk later",
                    "Check in on hydration"
                ]
            )
        } else {
            return CoachSuggestion(
                title: "Small boost time",
                reason: "A little effort can push you into green.",
                actions: [
                    "1-minute breathing",
                    "Short stretch break",
                    "Clear one quick reminder"
                ]
            )
        }
    }
}
