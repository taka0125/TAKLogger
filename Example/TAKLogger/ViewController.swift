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
    let logger = TAKLogger.sharedInstance
    logger.level = .Debug
    logger.formatter = TAKLogger.SimpleFormatter()
    logger.debug("Debug Message")
    logger.info("Info Message")
    logger.warn("Warn Message")
    logger.error("Error Message")
    logger.unknown("Unknown Message")
  }
  
  private func xcodeColorLoggerSample() {
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
    
    let logger = TAKLogger.sharedInstance
    logger.level = .Debug
    logger.formatter = TAKLogger.XcodeColorLogFormatter(foregroundColors: foregroundColors, backgroundColors: backgroundColors)
    logger.debug("Debug Message")
    logger.info("Info Message")
    logger.warn("Warn Message")
    logger.error("Error Message")
    logger.unknown("Unknown Message")
  }
}