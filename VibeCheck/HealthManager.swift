//
//  HealthManager.swift
//  VibeCheck
//
//  Created by Sudeep Thatiparthi on 2/4/26.
//

import SwiftUI
import HealthKit
internal import Combine

class HealthManager: ObservableObject {
    let healthStore = HKHealthStore()
    
    @Published var exercisePoints: Int = 0
    @Published var totalScore: Int = 100
    @Published var stressPenalty: Int = 0
    
    let typesToRead: Set = [
        HKQuantityType(.heartRate),
        HKQuantityType(.heartRateVariabilitySDNN),
        HKQuantityType(.activeEnergyBurned),
        HKQuantityType(.stepCount)
    ]
    
    func requestAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else { return }
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { success, error in
            if success {
                print("Permissions granted!")
                self.fetchDailyExercise() // Auto-fetch once permitted
            }
        }
    }

    func fetchDailyExercise() {
        let energyType = HKQuantityType(.activeEnergyBurned)
        let startOfDay = Calendar.current.startOfDay(for: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: Date(), options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: energyType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let sum = result?.sumQuantity() else { return }
            
            let calories = sum.doubleValue(for: .kilocalorie())
            
            
            DispatchQueue.main.async {
                self.exercisePoints = Int(calories / 50) * 5
                self.totalScore = 100 + self.exercisePoints
            }
        }
        healthStore.execute(query)
    }
    
    func fetchLatestHRV() {
        guard let hrvType = HKQuantityType.quantityType(forIdentifier: .heartRateVariabilitySDNN) else { return }
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(sampleType: hrvType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { (query, results, error) in
            guard let sample = results?.first as? HKQuantitySample else { return }
            
            let unit = HKUnit.secondUnit(with: .milli)
            let hrvValue = sample.quantity.doubleValue(for: unit)
            
            DispatchQueue.main.async {
                // Logic: If HRV is below 40ms, apply a penalty
                if hrvValue < 40 {
                    self.stressPenalty = 20
                } else {
                    self.stressPenalty = 0
                }
                // Recalculate Total Score
                self.totalScore = 100 + self.exercisePoints - self.stressPenalty
            }
        }
        healthStore.execute(query)
    }
}
