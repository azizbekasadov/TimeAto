//
//  AppDelegate.swift
//  TimeAto
//
//  Created by Azizbek Asadov on 03.12.2025.
//

import Cocoa

@main
final class AppDelegate: NSObject, NSApplicationDelegate {
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
}

