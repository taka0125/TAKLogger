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

public final class TAKLogger {
  public static let sharedInstance = TAKLogger()
  
  public enum Severity: Int {
    case Debug = 0
    case Info = 1
    case Warn = 2
    case Error = 3
    case Fatal = 4
    case Unknown = 5    
  }
  
  public var level: Severity = .Unknown
  public var formatter: LogFormattable = SimpleFormatter()
  
  private init() {
  }
  
  // MARK: - class func
  
  public class func debug(message: String) {
    sharedInstance.debug(message)
  }
  
  public class func info(message: String) {
    sharedInstance.info(message)
  }
  
  public class func warn(message: String) {
    sharedInstance.warn(message)
  }
  
  public class func error(message: String) {
    sharedInstance.error(message)
  }
  
  public class func fatal(message: String) {
    sharedInstance.fatal(message)
  }
  
  public class func unknown(message: String) {
    sharedInstance.unknown(message)
  }

  // MARK: - func
  
  public func debug(message: String) {
    write(.Debug, message)
  }
  
  public func info(message: String) {
    write(.Info, message)
  }
  
  public func warn(message: String) {
    write(.Warn, message)
  }
  
  public func error(message: String) {
    write(.Error, message)
  }
  
  public func fatal(message: String) {
    write(.Fatal, message)
  }
  
  public func unknown(message: String) {
    write(.Unknown, message)
  }
  
  // MARK: - Private Methods
  
  private func write(severity: Severity, _ message: String) {
    if level.rawValue > severity.rawValue { return }
    formatter.call(severity, time: NSDate(), message: message)
  }
}
