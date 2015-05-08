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
    let blogStore = BlogStore()
    
    if let latest = blogStore.latestEntry()
    {
      populateLatest(latest)
    }
    
  }
  
  func populateLatest(blogEntry:BlogEntry)
  {
    self.blogTitleLabel.setText(blogEntry.title)
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
