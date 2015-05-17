//
//  BlogStore.swift
//  SethGodin
//
//  Created by Kraig Spear on 5/6/15.
//  Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import Foundation


@objc public class BlogEntry : NSObject
{
  let itemId: String
  let title:String
  let summary: String
  let content: String
  let urlStr: String
  let date: NSDate
  
  init(itemId: String, title:String, summary:String, content:String, urlStr: String, date:NSDate)
  {
    self.itemId = itemId
    self.title = title
    self.summary = summary
    self.content = content
    self.urlStr = urlStr
    self.date = date
  }
  
}

public class BlogStore
{
  var blogEntries:[BlogEntry] = []
  
  public func latestEntry() -> BlogEntry?
  {
    load()
    
    if blogEntries.count > 0
    {
      return blogEntries[0]
    }
    else
    {
      return nil
    }
  }
  
  func load()
  {
    
    if let url = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.com.spearware.sethgodin")
    {
      let fileUrl = url.URLByAppendingPathComponent("blogEntries.json")
      
      if let jsonData = NSData(contentsOfURL: fileUrl)
      {
        let errorPointer = NSErrorPointer()
        
        if let blogEntriesDict = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.allZeros, error: errorPointer) as? [ [String:String]  ]
        {
          
          self.blogEntries.removeAll(keepCapacity: true)
          let dateFormatter = self.dateFormatter
          
          for blogEntryDict in blogEntriesDict
          {
            let title = blogEntryDict["title"]!
            let blogDate = dateFormatter.dateFromString(blogEntryDict["date"]!)!
            let summary = blogEntryDict["summary"]!
            let content = blogEntryDict["content"]!
            let itemId = blogEntryDict["itemId"]!
            let urlStr = blogEntryDict["urlStr"]!
            
            let blogEntry = BlogEntry(itemId: itemId, title: title, summary: summary, content: content, urlStr: urlStr, date: blogDate)
            
            blogEntries.append(blogEntry)
          }
        }
      }
    }
  }
  
  lazy var dateFormatter: NSDateFormatter =
  {
    let local = NSLocale(localeIdentifier: "en_US")
    let formatter = NSDateFormatter()
    formatter.locale = local
    formatter.dateStyle = NSDateFormatterStyle.LongStyle
    formatter.timeStyle = NSDateFormatterStyle.LongStyle
    return formatter
  }()
}