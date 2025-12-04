//
//  TaskTimes.swift
//  TimeAto
//
//  Created by Azizbek Asadov on 03.12.2025.
//

import Foundation

enum TaskTimes {
#if DEBUG
  // in debug mode, shorten all the times to make testing faster
  static let taskTime: TimeInterval = 2 * 60
  static let shortBreakTime: TimeInterval = 1 * 60
  static let longBreakTime: TimeInterval = 3 * 60
#else
  static let taskTime: TimeInterval = 25 * 60
  static let shortBreakTime: TimeInterval = 5 * 60
  static let longBreakTime: TimeInterval = 30 * 60
#endif
}
