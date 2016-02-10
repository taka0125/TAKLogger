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
  
  private func simpleLoggerSample() {
    TAKLogger.level = .Debug
    TAKLogger.formatter = TAKLogger.SimpleFormatter()
    
    TAKLogger.debug("Debug Message")
    TAKLogger.info("Info Message")
    TAKLogger.warn("Warn Message")
    TAKLogger.error("Error Message")
    TAKLogger.unknown("Fatal Message")
  }
  
  private func xcodeColorLoggerSample() {
    setenv("XcodeColors", "YES", 0)
    
    let foregroundColors: [TAKLogger.Severity : UIColor] = [
      .Debug: UIColor.grayColor(),
      .Info: UIColor.blueColor(),
      .Warn: UIColor.yellowColor(),
      .Error: UIColor.redColor()
    ]
    
    let backgroundColors: [TAKLogger.Severity : UIColor] = [
      .Debug: UIColor.redColor(),
      .Info: UIColor.yellowColor(),
      .Warn: UIColor.blueColor(),
      .Error: UIColor.grayColor()
    ]
    
    TAKLogger.level = .Debug
    TAKLogger.formatter = TAKLogger.XcodeColorLogFormatter(foregroundColors: foregroundColors, backgroundColors: backgroundColors)
    TAKLogger.debug("Debug Message")
    TAKLogger.info("Info Message")
    TAKLogger.warn("Warn Message")
    TAKLogger.error("Error Message")
    TAKLogger.unknown("Unknown Message")
  }
}