//
//  TaskManager+.swift
//  TimeAto
//
//  Created by Azizbek Asadov on 04.12.2025.
//

import Foundation

extension TaskManager {
    var menuTitleAndIcon: (title: String, icon: String) {
        switch timerState {
        case .runningTask(let taskIndex):
            let task = tasks[taskIndex]
            
            if let startTime = task.startTime {
                let remainingTime = differenceToHourMinFormat(
                    start: startTime,
                    duration: TaskTimes.taskTime
                )
                return ("\(task.title) - \(remainingTime)", task.status.iconName)
            } else {
                return ("TimeAto", "timer")
            }
        case .takingShortBreak(let startTime):
            let remainingTime = differenceToHourMinFormat(
                start: startTime,
                duration: TaskTimes.shortBreakTime
            )
            return ("Short Break - \(remainingTime)", "cup.and.saucer")
        case .takingLongBreak(let startTime):
            let remainingTime = differenceToHourMinFormat(
                start: startTime,
                duration: TaskTimes.longBreakTime
            )
            return ("Long Break - \(remainingTime)", "figure.walk")
        case .waiting:
            return ("TimeAto", "timer")
        }
    }
    
    func differenceToHourMinFormat(start: Date, duration: TimeInterval) -> String {
        let endTime = start.addingTimeInterval(duration)
        let remainingTime = endTime.timeIntervalSince(Date())
        if let difference = dateFormatter.string(from: remainingTime) {
            return difference
        }
        return ""
    }
}

private let dateFormatter: DateComponentsFormatter = {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.minute, .second]
    formatter.zeroFormattingBehavior = .pad
    return formatter
}()
