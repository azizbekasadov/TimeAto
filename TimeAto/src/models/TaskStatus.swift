//
//  TaskStatus.swift
//  TimeAto
//
//  Created by Azizbek Asadov on 03.12.2025.
//

import AppKit

enum TaskStatus: Int, Codable {
    case notStarted
    case inProgress
    case complete
    
    var statusText: String {
        switch self {
        case .notStarted:
            return "Not started yet"
        case .inProgress:
            return ""
        case .complete:
            return "Complete"
        }
    }
    
    var textColor: NSColor {
        switch self {
        case .notStarted:
            return .labelColor
        case .inProgress:
            return .controlAccentColor
        case .complete:
            return .placeholderTextColor
        }
    }
    
    var iconName: String {
        switch self {
        case .notStarted:
            return "square"
        case .inProgress:
            return "timer"
        case .complete:
            return "checkmark.square"
        }
    }
}
