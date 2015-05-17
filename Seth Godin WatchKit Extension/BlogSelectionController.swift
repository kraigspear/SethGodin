//
//  InterfaceController.swift
//  Seth Godin WatchKit Extension
//
//  Created by Kraig Spear on 4/12/15.
//  Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import WatchKit
import Foundation


class BlogSelectionController: WKInterfaceController {
  
  var blogEntries:[BlogEntry]! = []
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
  //  fetchLatest()
  }
  
  @IBAction func refreshAction()
  {
    fetchLatest()
  }
  
  func fetchLatest()
  {
    
    let numberToFetch: NSNumber = 7
    
    let userInfo = ["fetch" : "latest",
      "numberToFetch" : numberToFetch]
    
    GlanceController.openParentApplication(userInfo) { [weak self]
      (replyDictionary, error) -> Void in
      
      if let unwrapError = error
      {
        println("Error from getting data from iPhone App \(unwrapError)")
      }
      else
      {
        if let strongSelf = self
        {
          if let errorFromDict = replyDictionary["error"] as? NSError
          {
            println("Error from getting data from iPhone App \(errorFromDict)")
          }
          else if let results = replyDictionary["results"] as? [ [String:AnyObject]  ]
          {
            if results.count == 0
            {
              println("noting came back")
            }
            println("results came back #\(results.count)")
            strongSelf.populateTable(results)
          }
          else
          {
            println("didn't get the correct results from the App")
          }
        }
      }
    }
  }
  
  private func populateTable(blogEntries:[ [String:AnyObject] ])
  {
    
    self.blogEntries.removeAll(keepCapacity: true)
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
    
    self.table.setNumberOfRows(blogEntries.count, withRowType: "BlogRowType")
    
    for (index, element) in enumerate(blogEntries)
    {
      let controller = table.rowControllerAtIndex(index) as! BlogEntryRowController
      let title = element["title"] as! String
      let date = element["datePublished"] as! NSDate
      let dateStr = date.friendyDateString()
      let itemId = element["itemId"] as! String
      let summary = element["summary"] as! String
      let content = element["content"] as! String
      let urlStr = element["urlStr"] as! String
      
      controller.textLabel.setText(title)
      controller.dateLabel.setText(dateStr)
      
      let blogEntry = BlogEntry(itemId: itemId, title: title, summary: summary, content: content, urlStr: urlStr, date: date)
      
      self.blogEntries.append(blogEntry)
    }
    
  }
  
  override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject?
  {
    return self.blogEntries[rowIndex]
  }
  
  @IBOutlet weak var table: WKInterfaceTable!
  
  override func willActivate()
  {
    super.willActivate()
    //fetchLatest()
  }
  
  override func didDeactivate()
  {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
}
