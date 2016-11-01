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
  func call(severity: TAKLogger.Severity, time: NSDate, message: String)
}

public struct TAKLogger {
  public enum Severity: Int {
    case Debug = 0
    case Info = 1
    case Warn = 2
    case Error = 3
    case Fatal = 4
    case Unknown = 5    
  }
  
  public static var level: Severity = .Unknown
  public static var formatter: LogFormattable = SimpleFormatter()
  
  // MARK: - class func
  
  public static func debug(object: AnyObject) {
    write(.Debug, "\(object)")
  }

  public static func info(object: AnyObject) {
    write(.Info, "\(object)")
  }
  
  public static func warn(object: AnyObject) {
    write(.Warn, "\(object)")
  }
  
  public static func error(object: AnyObject) {
    write(.Error, "\(object)")
  }
  
  public static func fatal(object: AnyObject) {
    write(.Fatal, "\(object)")
  }
  
  public static func unknown(object: AnyObject) {
    write(.Unknown, "\(object)")
  }
}

// MARK: - Private Methods

extension TAKLogger {
  private static func write(severity: Severity, _ message: String) {
    if level.rawValue > severity.rawValue { return }
    formatter.call(severity, time: NSDate(), message: message)
  }
}
