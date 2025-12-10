//
//  AppDelegate.swift
//  TimeAto
//
//  Created by Azizbek Asadov on 03.12.2025.
//

import Cocoa

@main
final class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet weak var launchOnLoginMenuItem: NSMenuItem!
    @IBOutlet private weak var startStopMenuItem: NSMenuItem!
    @IBOutlet private weak var mainMenu: NSMenu!
    
    private var menuManager: MenuManager?
    private var statusItem: NSStatusItem?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        confitgureStatusBarItem()
        
        menuManager = MenuManager(statusMenu: self.mainMenu)
        mainMenu.delegate = menuManager
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    // MARKL: - Helpers
    
    private func confitgureStatusBarItem() {
        statusItem = NSStatusBar.system.statusItem(
            withLength: NSStatusItem.variableLength
        )
        
        statusItem?.menu = self.mainMenu
        statusItem?.button?.title = "Time-Ato"
        statusItem?.button?.imagePosition = .imageLeading
        statusItem?.button?.image = NSImage(
            systemSymbolName: "timer",
            accessibilityDescription: "Time-Ato"
        )
        statusItem?.button?.font = NSFont.monospacedDigitSystemFont(
            ofSize: NSFont.systemFontSize,
            weight: .regular
        )
    }
    
    func updateMenu(
        title: String,
        icon: String,
        taskIsRunning: Bool
    ) {
        statusItem?.button?.title = title
        statusItem?.button?.image = NSImage(
            systemSymbolName: icon,
            accessibilityDescription: title
        )
        
        updateMenuItemTitles(taskIsRunning: taskIsRunning)
        
        if menuManager?.menuIsOpen == true {
            menuManager?.updateMenuItems()
        }
    }
    
    func updateMenuItemTitles(taskIsRunning: Bool) {
        if taskIsRunning {
            startStopMenuItem.title = "Mark Task as Complete"
        } else {
            startStopMenuItem.title = "Start Next Task"
        }
    }
    
    // MARK: - IBActions
    
    @IBAction private func startNewTaskAction(_ sender: NSMenuItem) {
        menuManager?.taskManager.toggleTask()
    }
    
    @IBAction private func editTaskAction(_ sender: NSMenuItem) {
        
    }
    
    @IBAction private func launchOnLoginAction(_ sender: NSMenuItem) {
    }
}

