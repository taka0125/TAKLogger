//
//  TAKLogger.swift
//  TAKLogger
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation

public protocol LogFormattable {
  func call(_ severity: TAKLogger.Severity, time: Date, message: String)
}

public struct TAKLogger {
  public enum Severity: Int {
    case debug = 0
    case info = 1
    case warn = 2
    case error = 3
    case fatal = 4
    case unknown = 5    
  }
  
  public static var level: Severity = .unknown
  public static var formatter: LogFormattable = SimpleFormatter()
  
  // MARK: - class func
  
  public static func debug(_ object: Any) {
    write(.debug, "\(object)")
  }

  public static func info(_ object: Any) {
    write(.info, "\(object)")
  }
  
  public static func warn(_ object: Any) {
    write(.warn, "\(object)")
  }
  
  public static func error(_ object: Any) {
    write(.error, "\(object)")
  }
  
  public static func fatal(_ object: Any) {
    write(.fatal, "\(object)")
  }
  
  public static func unknown(_ object: Any) {
    write(.unknown, "\(object)")
  }
}

// MARK: - Private Methods

extension TAKLogger {
  fileprivate static func write(_ severity: Severity, _ message: String) {
    if level.rawValue > severity.rawValue { return }
    formatter.call(severity, time: Date(), message: message)
  }
}
