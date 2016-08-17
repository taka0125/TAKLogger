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
    
    fileprivate static let DateFormatter: Foundation.DateFormatter = {
      let f = Foundation.DateFormatter()
      f.formatterBehavior = .behavior10_4
      f.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
      return f
    }()
    
    public func call(_ severity: TAKLogger.Severity, time: Date, message: String) {
      print("[\(label(severity))][\(SimpleFormatter.DateFormatter.string(from: time))] \(message)")
    }
    
    fileprivate func label(_ severity: TAKLogger.Severity) -> String {
      switch severity {
      case .debug: return "D"
      case .info: return "I"
      case .warn: return "W"
      case .error: return "E"
      case .fatal: return "F"
      case .unknown: return "U"
      }
    }
  }
}
