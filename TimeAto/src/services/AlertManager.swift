//
//  Alerter.swift
//  TimeAto
//
//  Created by Azizbek Asadov on 04.12.2025.
//

import AppKit

struct AlertManager {
    func taskComplete(_ title: String, at index: Int) {
        var breakLength = "\(Int(TaskTimes.shortBreakTime / 60))"
        if (index + 1).isMultiple(of: 4) {
            breakLength = "\(Int(TaskTimes.longBreakTime / 60))"
        }
        
        let part1Msg = "The \"\(title)\" task is complete.\n\n"
        let part2Msg = "Time to take a \(breakLength) minute break."
        let message = part1Msg + part2Msg
        
        openAlert(
            title: "Task Complete",
            message: message,
            buttonTitles: ["Start Break"]
        )
    }
    
    func allTasksComplete() {
        let message = "Congratulations!\n\n" +
        "All your tasks for today are complete."
        
        openAlert(title: "All Tasks Complete", message: message)
    }
    
    func breakOver() -> NSApplication.ModalResponse {
        let message = "Your break time has finished.\n\n" +
        "Start your next task now or use the menu to start it when you're ready."
        
        let buttonTitles = ["Start Next Task", "OK"]
        
        let response = openAlert(
            title: "Break Over",
            message: message,
            buttonTitles: buttonTitles
        )

        return response
    }
    
    @discardableResult
    func openAlert(title: String, message: String, buttonTitles: [String] = []) -> NSApplication.ModalResponse {
        
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = message
        
        for buttonTitle in buttonTitles {
            alert.addButton(withTitle: buttonTitle)
        }
        
        NSApp.activate(ignoringOtherApps: true)
        
        return alert.runModal()
    }
}
