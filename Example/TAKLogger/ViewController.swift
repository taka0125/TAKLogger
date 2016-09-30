//
//  ViewController.swift
//  TAKLogger
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import UIKit
import TAKLogger

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    simpleLoggerSample()
    xcodeColorLoggerSample()
  }
  
  fileprivate func simpleLoggerSample() {
    TAKLogger.level = .debug
    TAKLogger.formatter = TAKLogger.SimpleFormatter()
    
    TAKLogger.debug("Debug Message")
    TAKLogger.info("Info Message")
    TAKLogger.warn("Warn Message")
    TAKLogger.error("Error Message")
    TAKLogger.unknown("Fatal Message")
  }
  
  fileprivate func xcodeColorLoggerSample() {
    setenv("XcodeColors", "YES", 0)
    
    let foregroundColors: [TAKLogger.Severity : UIColor] = [
      .debug: UIColor.gray,
      .info: UIColor.blue,
      .warn: UIColor.yellow,
      .error: UIColor.red
    ]
    
    let backgroundColors: [TAKLogger.Severity : UIColor] = [
      .debug: UIColor.red,
      .info: UIColor.yellow,
      .warn: UIColor.blue,
      .error: UIColor.gray
    ]
    
    TAKLogger.level = .debug
    TAKLogger.formatter = TAKLogger.XcodeColorLogFormatter(foregroundColors: foregroundColors, backgroundColors: backgroundColors)
    TAKLogger.debug("Debug Message")
    TAKLogger.info("Info Message")
    TAKLogger.warn("Warn Message")
    TAKLogger.error("Error Message")
    TAKLogger.unknown("Unknown Message")
  }
}
