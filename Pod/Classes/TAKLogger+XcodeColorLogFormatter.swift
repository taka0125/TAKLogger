//
//  TAKLogger+XcodeColorLogFormatter.swift
//  TAKLogger
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

#if os(iOS)
  import UIKit
#endif

public extension TAKLogger {
  public class XcodeColorLogFormatter: LogFormattable {
    fileprivate static let DateFormatter: Foundation.DateFormatter = {
      let f = Foundation.DateFormatter()
      f.formatterBehavior = .behavior10_4
      f.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
      return f
    }()
    
    fileprivate struct Const {
      static let Escape = "\u{001b}["
      static let Reset = Escape + ";"
    }
    
    #if os(iOS)
    public typealias Color = UIColor
    #elseif os(OSX)
    public typealias Color = NSColor
    #endif

    fileprivate let foregroundColors: [TAKLogger.Severity: Color]?
    fileprivate let backgroundColors: [TAKLogger.Severity: Color]?

    public init(foregroundColors: [TAKLogger.Severity: Color]?, backgroundColors: [TAKLogger.Severity: Color]?) {
      self.foregroundColors = foregroundColors
      self.backgroundColors = backgroundColors
    }
    
    open func call(_ severity: TAKLogger.Severity, time: Date, message: String) {
      let fg = foregroundColorString(severity)
      let bg = backgroundColorString(severity)
      
      var string = "[\(label(severity))][\(XcodeColorLogFormatter.DateFormatter.string(from: time))] \(message)"
      if fg != nil || bg != nil {
        let foreground = fg ?? ""
        let background = bg ?? ""
        string = "\(foreground)\(background)\(string)\(Const.Reset)"
      }
      
      print(string)
    }
    
    fileprivate func foregroundColorString(_ severity: TAKLogger.Severity) -> String? {
      if let color = foregroundColors?[severity] {
        let (r, g, b) = parseRGB(color)
        return "\(Const.Escape)fg\(r),\(g),\(b);"
      }
      return nil
    }
    
    fileprivate func backgroundColorString(_ severity: TAKLogger.Severity) -> String? {
      if let color = backgroundColors?[severity] {
        let (r, g, b) = parseRGB(color)
        return "\(Const.Escape)bg\(r),\(g),\(b);"
      }
      return nil
    }
    
    fileprivate func parseRGB(_ color: Color) -> (Int, Int, Int) {
      var fRed: CGFloat = 0
      var fGreen: CGFloat = 0
      var fBlue: CGFloat = 0
      
      color.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: nil)
      
      let red = Int(fRed * 255.0)
      let green = Int(fGreen * 255.0)
      let blue = Int(fBlue * 255.0)
      
      return (red, green, blue)
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
