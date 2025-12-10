//
//  MenuManager.swift
//  TimeAto
//
//  Created by Azizbek Asadov on 03.12.2025.
//

import AppKit
import Foundation

final class MenuManager: NSObject {
    private let statusMenu: NSMenu
    
    private(set) var menuIsOpen = false
    
    private let itemsBeforeTasks = 2
    private let itemsAfterTasks = 6
    
    lazy var taskManager = TaskManager()
    lazy var notifier = Notifier()
    
    init(statusMenu: NSMenu) {
        self.statusMenu = statusMenu
        
        super.init()
    }
    
    func updateMenuItems() {
        for item in statusMenu.items {
            if let view = item.view as? TaskView {
                view.setNeedsDisplay(.infinite)
            }
        }
    }
    
    private func clear() {
        let stopAtIndex = max(0, statusMenu.items.count - itemsAfterTasks)

        if stopAtIndex > itemsBeforeTasks {
            for _ in itemsBeforeTasks ..< stopAtIndex {
                statusMenu.removeItem(at: itemsBeforeTasks)
            }
        }
    }
    
    private func showTasksInMenu() {
        var index = itemsBeforeTasks
        var taskCounter = 0
        let itemFrame = NSRect(x: 0, y: 0, width: 270, height: 40)
        
        for task in taskManager.tasks {
            let item = NSMenuItem()
            let itemView = TaskView(frame: itemFrame)
            itemView.task = task
            item.view = itemView
            
            statusMenu.insertItem(item, at: index)
            index += 1
            taskCounter += 1

            if taskCounter.isMultiple(of: 4) {
                statusMenu.insertItem(NSMenuItem.separator(), at: index)
                index += 1
            }
        }
    }
}

extension MenuManager: NSMenuDelegate {
    func menuWillOpen(_ menu: NSMenu) {
        menuIsOpen = true
        
        showTasksInMenu()
    }
    
    func menuDidClose(_ menu: NSMenu) {
        menuIsOpen = false
        
        clear()
    }
}
