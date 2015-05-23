//
//  InterfaceController.swift
//  Seth Godin WatchKit Extension
//
//  Created by Kraig Spear on 4/12/15.
//  Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import WatchKit
import Foundation

/**
The ViewController that shows a list of blog entries to be selected to read
*/
class BlogSelectionController: WKInterfaceController {
  
  /**
  The blog entires currently being displayed
  */
  private var blogEntries:[BlogEntry]! = []
  
  /*
  The table that shows the blog entry content.
  */
  @IBOutlet weak var table: WKInterfaceTable!
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    fetchLatest()
  }
  
  /**
  Fetch the latest blog content so that we can display them
  */
  private func fetchLatest()
  {
    
    let numberToFetch: Int = 7
    
    //The responder knows how to handle the responses coming back from the parent iPhone App
    //We are a simpled minded ViewController that has no business knowing how to do that.
    let responder = WatchKitResponder()
    
    responder.onBlogEntries = {[weak self] (blogEntries:[BlogEntry]?, error:NSError?) in
      
      if let unwrapSelf = self
      {
        if let unwrapEntries = blogEntries
        {
          unwrapSelf.populateTable(unwrapEntries)
        }
        
        if let unwrapError = error
        {
          
        }
      }
      
    }
    
    //1. Get the user info request needed to make the call, providing how many that we want returned.
    let userInfo = responder.userInfoForFetch(numberToFetch)
   
    //2. Ask the parent App for the latest entries, giving a refrence to responder to handle the response
    BlogSelectionController.openParentApplication(userInfo, reply: responder.processLatestBlogEntries)
  }
  
  /**
  Populate the table with blog entries
  1. Assign blogEntries memeber to blogEntries
     Why? Will need to select the blog entry from the index later when the user chooses one to read
  2. Create a date formatter with the format that we are displaying
  3. Populate the table with title and date
  */
  private func populateTable(blogEntries:[BlogEntry])
  {
    self.blogEntries = blogEntries
    self.table.setNumberOfRows(blogEntries.count, withRowType: "BlogRowType")
    
    for (index, element) in enumerate(blogEntries)
    {
      let controller = table.rowControllerAtIndex(index) as! BlogEntryRowController
      controller.textLabel.setText(element.title)
      controller.dateLabel.setText(shortTimeFormatter.stringFromDate(element.date))
    }
    
  }
  
  /**
  A short time formatter for the time of the blog post.
  */
  private lazy var shortTimeFormatter:NSDateFormatter =
  {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
    return dateFormatter
  }()
  
  /**
  Give the new ViewController blogEntry item that they selected
  */
  override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject?
  {
    return self.blogEntries[rowIndex]
  }
  
  // MARK: Menu
  
  
 }
