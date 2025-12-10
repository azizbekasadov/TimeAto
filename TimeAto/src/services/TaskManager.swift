//
//  TaskManager.swift
//  TimeAto
//
//  Created by Azizbek Asadov on 04.12.2025.
//

import AppKit
import Combine
import Foundation

final class TaskManager {
    
//    private let interaction = AlertManager()
    private let interaction = Notifier()
    private(set) var tasks: [TaskItem] = TaskItem.sampleTasks
    private var timerCancellable: AnyCancellable?
    private var timerState: TimerState = .waiting
    
    func startTimer() {
        timerCancellable = Timer
            .publish(
                every: 1,
                tolerance: 0.5,
                on: .current,
                in: .common
            )
            .autoconnect()
            .sink { [weak self] time in
                self?.checkTimings()
            }
    }
    
    func toggleTask() {
        if let activeTaskIndex = timerState.activeTaskIndex {
            stopRunningTask(at: activeTaskIndex)
        } else {
            startNextTask()
        }
    }
    
    func startNextTask() {
        let nextTaskIndex = tasks.firstIndex {
            $0.status == .notStarted
        }
        
        if let nextTaskIndex = nextTaskIndex {
            tasks[nextTaskIndex].start()
            timerState = .runningTask(taskIndex: nextTaskIndex)
        }
    }
    
    func stopRunningTask(at taskIndex: Int) {
        tasks[taskIndex].complete()
        timerState = .waiting
        
        if taskIndex < tasks.count - 1 {
            startBreak(after: taskIndex)
        }
    }
    
    func checkTimings() {
        let taskIsRunning = timerState.activeTaskIndex != nil
        
        if let appDelegate = NSApp.delegate as? AppDelegate {
            let (title, icon) = menuTitleAndIcon

            appDelegate.updateMenu(
                title: title,
                icon: icon,
                taskIsRunning: taskIsRunning
            )
        }
        
        switch timerState {
        case .runningTask(let taskIndex):
            checkForTaskFinish(activeTaskIndex: taskIndex)
        case .takingShortBreak(let startTime), .takingLongBreak(let startTime):
            if let breakDuration = timerState.breakDuration {
                checkForBreakFinish(
                    startTime: startTime,
                    duration: breakDuration
                )
            }
        default: break
        }
    }
    
    func checkForTaskFinish(activeTaskIndex: Int) {
        let activeTask = tasks[activeTaskIndex]
        if activeTask.progressPercent >= 100 {
            stopRunningTask(at: activeTaskIndex)
        }
        
        if activeTaskIndex == tasks.count - 1 {
            interaction.allTasksComplete()
        } else {
            interaction.taskComplete(
                title: activeTask.title,
                index: activeTaskIndex
            )
        }
    }
    
    func checkForBreakFinish(startTime: Date, duration: TimeInterval) {
        let elapsedTime = -startTime.timeIntervalSinceNow
        
        if elapsedTime >= duration {
            timerState = .waiting
            
//            if interaction.breakOver() == .alertFirstButtonReturn {
//                startNextTask()
//            }
            
            interaction.startNextTaskFunc = startNextTask
            interaction.breakOver()
        }
    }
    
    func startBreak(after index: Int) {
        let oneSecondFromNow = Date(timeIntervalSinceNow: 1)
        
        if (index + 1).isMultiple(of: 4) {
            timerState = .takingLongBreak(startTime: oneSecondFromNow)
        } else {
            timerState = .takingShortBreak(startTime: oneSecondFromNow)
        }
    }
}
