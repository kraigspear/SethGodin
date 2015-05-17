//
//  DateUtil.swift
//  SpearLib
//
//  Created by Kraig Spear on 5/12/15.
//  Copyright (c) 2015 spearware. All rights reserved.
//

import Foundation

let calendar = NSCalendar.currentCalendar()
var dateFormatter: NSDateFormatter?

extension NSDate
{
    func friendyDateString() -> String
    {
      
      if dateFormatter == nil
      {
        dateFormatter = NSDateFormatter()
        dateFormatter!.dateFormat = "cccc"
      }
      
      switch(self.numberOfDaysSinceOtherDay())
      {
      case 0:
        return "Today"
      case 1:
        return "Yesterday"
      default:
        return dateFormatter!.stringFromDate(self)
      }
    }
  
  func numberOfDaysSinceOtherDay(date: NSDate = NSDate()) -> Int
  {
    
    let flags: NSCalendarUnit = NSCalendarUnit.CalendarUnitDay
    let components = calendar.components(flags, fromDate: self, toDate: date, options:nil)
    return components.day
  }
}