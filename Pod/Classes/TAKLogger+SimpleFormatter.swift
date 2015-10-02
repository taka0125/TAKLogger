//
//  TAKLogger+SimpleFormatter.swift
//  TAKLogger
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

public extension TAKLogger {
  public class SimpleFormatter: LogFormattable {
    public init() {
    }
    
    private static let DateFormatter: NSDateFormatter = {
      let f = NSDateFormatter()
      f.formatterBehavior = .Behavior10_4
      f.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
      return f
    }()
    
    public func call(severity: TAKLogger.Severity, time: NSDate, message: String) {
      print("[\(label(severity))][\(SimpleFormatter.DateFormatter.stringFromDate(time))] \(message)")
    }
    
    private func label(severity: TAKLogger.Severity) -> String {
      switch severity {
      case .Debug: return "D"
      case .Info: return "I"
      case .Warn: return "W"
      case .Error: return "E"
      case .Fatal: return "F"
      case .Unknown: return "U"
      }
    }
  }
}
