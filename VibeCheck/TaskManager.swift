//
//  TaskManager.swift
//  VibeCheck
//
//  Created by Sudeep Thatiparthi on 2/4/26.
//

import EventKit
import SwiftUI
internal import Combine

class TaskManager: ObservableObject {
    let eventStore = EKEventStore()
    
    @Published var taskPenalty: Int = 0
    
    func fetchTaskLoad() {
        eventStore.requestFullAccessToReminders { granted, error in
            if granted {
                let predicate = self.eventStore.predicateForIncompleteReminders(withDueDateStarting: nil, ending: Date(), calendars: nil)
                
                self.eventStore.fetchReminders(matching: predicate) { reminders in
                    DispatchQueue.main.async {
                        let count = reminders?.count ?? 0
                        // Penalty: -5 points for every incomplete task (max 30)
                        self.taskPenalty = min(count * 5, 30)
                    }
                }
            }
        }
    }
}
