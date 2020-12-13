//
//  BlogStore.swift
//  SethGodin
//
//  Created by Kraig Spear on 5/6/15.
//  Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import Foundation


@objc open class BlogEntry : NSObject
{
  let itemId: String
  let title:String
  let summary: String
  let content: String
  let urlStr: String
  let date: Date
  
  init(itemId: String, title:String, summary:String, content:String, urlStr: String, date:Date)
  {
    self.itemId = itemId
    self.title = title
    self.summary = summary
    self.content = content
    self.urlStr = urlStr
    self.date = date
  }
  
}

open class BlogStore
{
  var blogEntries:[BlogEntry] = []
  
  open func latestEntry() -> BlogEntry?
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
    
    if let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.spearware.sethgodin")
    {
      let fileUrl = url.appendingPathComponent("blogEntries.json")
      
      if let jsonData = try? Data(contentsOf: fileUrl)
      {
        if let blogEntriesDict = try! JSONSerialization.jsonObject(with: jsonData, options: []) as? [ [String:String]  ]
        {
          
          self.blogEntries.removeAll(keepingCapacity: true)
          let dateFormatter = self.dateFormatter
          
          for blogEntryDict in blogEntriesDict
          {
            let title = blogEntryDict["title"]!
            let blogDate = dateFormatter.date(from: blogEntryDict["date"]!)!
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
  
  lazy var dateFormatter: DateFormatter =
  {
    let local = Locale(identifier: "en_US")
    let formatter = DateFormatter()
    formatter.locale = local
    formatter.dateStyle = DateFormatter.Style.long
    formatter.timeStyle = DateFormatter.Style.long
    return formatter
  }()
}
