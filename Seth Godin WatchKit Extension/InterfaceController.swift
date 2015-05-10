//
//  InterfaceController.swift
//  Seth Godin WatchKit Extension
//
//  Created by Kraig Spear on 4/12/15.
//  Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    populateTable()
  }
  
  func populateTable()
  {
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
    
    let blogStore = BlogStore()
    
    blogStore.load()
    
    self.table.setNumberOfRows(blogStore.blogEntries.count, withRowType: "BlogRowType")
    
    for (index, blogEntry) in enumerate(blogStore.blogEntries)
    {
      let controller = table.rowControllerAtIndex(index) as! BlogEntryRowController
      controller.textLabel.setText(blogEntry.title)
      controller.dateLabel.setText(dateFormatter.stringFromDate(blogEntry.date))
    }
  }
  
  @IBOutlet weak var table: WKInterfaceTable!
  
  override func willActivate()
  {
    super.willActivate()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
}
