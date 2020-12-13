//
//  DateUtil.swift
//  SpearLib
//
//  Created by Kraig Spear on 5/12/15.
//  Copyright (c) 2015 spearware. All rights reserved.
//

import Foundation

let calendar = Calendar.current
var dateFormatter: DateFormatter?

extension Date
{
    func friendyDateString() -> String
    {
      
      if dateFormatter == nil
      {
        dateFormatter = DateFormatter()
        dateFormatter!.dateFormat = "cccc"
      }
      
      switch(self.numberOfDaysSinceOtherDay())
      {
      case 0:
        return "Today"
      case 1:
        return "Yesterday"
      default:
        return dateFormatter!.string(from: self)
      }
    }
  
  func numberOfDaysSinceOtherDay(_ date: Date = Date()) -> Int {
	let flags: Set<Calendar.Component> = ([Calendar.Component.day])
	let components = calendar.dateComponents(flags, from: self, to: date)
    return components.day!
  }
}
