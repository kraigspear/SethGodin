//
//  GlanceController.swift
//  Seth Godin WatchKit Extension
//
//  Created by Kraig Spear on 4/12/15.
//  Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {
  
  
  
  @IBOutlet weak var dateTimeOfBlogEntryLabel: WKInterfaceLabel!
  @IBOutlet weak var blogTitleLabel: WKInterfaceLabel!
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
    self.fetchLatest()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
  func fetchLatest()
  {
    
    let numberToFetch: NSNumber = 1
    
    let userInfo = ["fetch" : "latest",
                    "numberToFetch" : numberToFetch]
    
    GlanceController.openParentApplication(userInfo) { [weak self]
      (replyDictionary, error) -> Void in
      
      if let unwrapError = error
      {
        println(unwrapError)
      }
      else
      {
        if let strongSelf = self
        {
          if let results = replyDictionary["results"] as? [ [String:String]  ]
          {
            strongSelf.populateLatest(results[0])
          }
          else
          {
            println("didn't get the correct results from the App")
          }
        }
      }
    }
  }
  
  func populateLatest(blogEntry:[String:String])
  {
    if let title: String = blogEntry["title"]
    {
      println("title = \(title)")
      self.blogTitleLabel.setText(title)
    }
    else
    {
      println("didn't find the title from the App results")
    }
    self.dateTimeOfBlogEntryLabel.setText("Today")
  }
  
  lazy var dateFormatter: NSDateFormatter =
  {
    let local = NSLocale(localeIdentifier: "en_US")
    let formatter = NSDateFormatter()
    formatter.locale = local
    formatter.dateStyle = NSDateFormatterStyle.ShortStyle
    return formatter
  }()
}
