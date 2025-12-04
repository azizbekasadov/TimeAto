//
//  Task.swift
//  TimeAto
//
//  Created by Azizbek Asadov on 03.12.2025.
//

import AppKit

struct TaskItem: Identifiable, Codable {
    let id: UUID
    var title: String
    var status: TaskStatus = .notStarted
    var startTime: Date?
    
    var progressPercent: Double {
        switch status {
        case .notStarted:
            return 0
        case .inProgress:
            if let startTime = startTime {
                let elapsedTime = -startTime.timeIntervalSinceNow
                let percentTime = elapsedTime / TaskTimes.taskTime
                return percentTime * 100
            }
            return 0
        case .complete:
            return 100
        }
    }
    
    mutating func start() {
        status = .inProgress
        startTime = Date(timeIntervalSinceNow: 1)
    }
    
    mutating func complete() {
        status = .complete
    }
    
    mutating func reset() {
        status = .notStarted
        startTime = nil
    }
}

// MARK: - Mock Data

extension TaskItem {
    static var sampleTasks: [TaskItem] = [
        TaskItem(id: UUID(), title: "Communications"),
        TaskItem(id: UUID(), title: "Status Meeting"),
        TaskItem(id: UUID(), title: "Project ABC - Ticket 42a"),
        TaskItem(id: UUID(), title: "Project ABC - Ticket 42b"),
        TaskItem(id: UUID(), title: "Project ABC - Ticket 42c"),
        TaskItem(id: UUID(), title: "Testing"),
        TaskItem(id: UUID(), title: "Documentation"),
        TaskItem(id: UUID(), title: "Project ABC - Ticket 123")
    ]
    
    static var sampleTasksWithStatus: [TaskItem] = [
        TaskItem(
            id: UUID(),
            title: "Communications",
            status: .complete,
            startTime: Date(timeIntervalSinceNow: -600)
        ),
        TaskItem(
            id: UUID(),
            title: "Status Meeting",
            status: .complete,
            startTime: Date(timeIntervalSinceNow: -300)
        ),
        TaskItem(
            id: UUID(),
            title: "Project ABC - Ticket 42a",
            status: .inProgress,
            startTime: Date(timeIntervalSinceNow: -60)
        ),
        TaskItem(id: UUID(), title: "Project ABC - Ticket 42b"),
        TaskItem(id: UUID(), title: "Project ABC - Ticket 42c"),
        TaskItem(id: UUID(), title: "Testing"),
        TaskItem(id: UUID(), title: "Documentation"),
        TaskItem(id: UUID(), title: "Project ABC - Ticket 123")
    ]
}
