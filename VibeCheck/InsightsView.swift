import SwiftUI
import Charts

struct ScoreSample: Identifiable {
    let id = UUID()
    let date: Date
    let score: Int
}

struct InsightsView: View {
    // Placeholder data until persistence is added
    let samples: [ScoreSample] = (0..<7).compactMap { i in
        guard let day = Calendar.current.date(byAdding: .day, value: -i, to: Date()) else { return nil }
        return ScoreSample(date: day, score: Int.random(in: 45...95))
    }.reversed()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Insights")
                    .font(.largeTitle).bold()

                Chart(samples) {
                    LineMark(
                        x: .value("Day", $0.date, unit: .day),
                        y: .value("Score", $0.score)
                    )
                    .foregroundStyle(.blue)
                    PointMark(
                        x: .value("Day", $0.date, unit: .day),
                        y: .value("Score", $0.score)
                    )
                }
                .frame(height: 220)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Patterns")
                        .font(.headline)
                    Text("Watch for dips after heavy task days or when HRV is low.")
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(.thinMaterial)
                .cornerRadius(12)
            }
            .padding()
        }
    }
}

#Preview {
    InsightsView()
}
