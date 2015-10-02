//
//  TAKLogger+XcodeColorLogFormatter.swift
//  TAKLogger
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

public extension TAKLogger {
  public class XcodeColorLogFormatter: LogFormattable {
    private static let DateFormatter: NSDateFormatter = {
      let f = NSDateFormatter()
      f.formatterBehavior = .Behavior10_4
      f.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
      return f
    }()
    
    private struct Const {
      static let Escape = "\u{001b}["
      static let Reset = Escape + ";"
    }
    
    private let foregroundColors: [TAKLogger.Severity: UIColor]?
    private let backgroundColors: [TAKLogger.Severity: UIColor]?
    
    public init(foregroundColors: [TAKLogger.Severity: UIColor]?, backgroundColors: [TAKLogger.Severity: UIColor]?) {
      self.foregroundColors = foregroundColors
      self.backgroundColors = backgroundColors
    }
    
    public func call(severity: TAKLogger.Severity, time: NSDate, message: String) {
      let fg = foregroundColorString(severity)
      let bg = backgroundColorString(severity)
      
      var string = "[\(label(severity))][\(XcodeColorLogFormatter.DateFormatter.stringFromDate(time))] \(message)"
      if fg != nil || bg != nil {
        let foreground = fg ?? ""
        let background = bg ?? ""
        string = "\(foreground)\(background)\(string)\(Const.Reset)"
      }
      
      print(string)
    }
    
    private func foregroundColorString(severity: TAKLogger.Severity) -> String? {
      if let color = foregroundColors?[severity] {
        let (r, g, b) = parseRGB(color)
        return "\(Const.Escape)fg\(r),\(g),\(b);"
      }
      return nil
    }
    
    private func backgroundColorString(severity: TAKLogger.Severity) -> String? {
      if let color = backgroundColors?[severity] {
        let (r, g, b) = parseRGB(color)
        return "\(Const.Escape)bg\(r),\(g),\(b);"
      }
      return nil
    }
    
    private func parseRGB(color: UIColor) -> (Int, Int, Int) {
      var fRed: CGFloat = 0
      var fGreen: CGFloat = 0
      var fBlue: CGFloat = 0
      
      color.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: nil)
      
      let red = Int(fRed * 255.0)
      let green = Int(fGreen * 255.0)
      let blue = Int(fBlue * 255.0)
      
      return (red, green, blue)
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
