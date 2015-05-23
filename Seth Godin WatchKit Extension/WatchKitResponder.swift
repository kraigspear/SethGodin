//
//  WatchKitResponder.swift
//  SethGodin
//
//  Created by Kraig Spear on 5/23/15.
//  Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import Foundation

typealias ProcessResponse = ( (response:[NSObject : AnyObject]?, error:NSError? ) )
typealias LatestBlogEntries = ([BlogEntry]?, NSError?) -> Void

/**
Processes responses back from the client app

*/
class WatchKitResponder
{
  
  var onBlogEntries:LatestBlogEntries?
  
  // MARK: Latest Blog Entries
  /**
  The code to handle the response coming back from the iPhone App for the latest
  blog entries.
  1. Determine if there is an error
  2. Turn the dictionary to real BlogEntry objects
  3. Give those objects to the caller.
  */
  func processLatestBlogEntries(response:ProcessResponse) -> Void
  {
    if let unwrapOnBlogEntries = self.onBlogEntries
    {
      if let unwrapResponse = response.response
      {
        if let results = unwrapResponse["results"] as? [ [String:AnyObject] ]
        {
          let blogEntries = convertDictionaryToBlogEntries(results)
          unwrapOnBlogEntries(blogEntries, nil)
        }
        else
        {
          assert(false, "didn't get results back?")
        }
      }
      else if let unwrapError = response.error
      {
        unwrapOnBlogEntries(nil, unwrapError)
      }
    }
  }
  
  //The request that is needed to get the latest blog entries.
  func userInfoForFetch(numberToFetch:Int) -> [NSObject:AnyObject]
  {
    let fetchNum:NSNumber = numberToFetch
    
    return ["fetch" : "latest",
      "numberToFetch" :fetchNum]
  }
  
  private func convertDictionaryToBlogEntries(resultDictionary:[ [String:AnyObject] ]) -> [BlogEntry]
  {
    var blogEntries: [BlogEntry] = []
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
    
    for (index, element) in enumerate(resultDictionary)
    {
      let title = element["title"] as! String
      let date = element["datePublished"] as! NSDate
      let dateStr = date.friendyDateString()
      let itemId = element["itemId"] as! String
      let summary = element["summary"] as! String
      let content = element["content"] as! String
      let urlStr = element["urlStr"] as! String
      
      let blogEntry = BlogEntry(itemId: itemId, title: title, summary: summary, content: content, urlStr: urlStr, date: date)
      
      blogEntries.append(blogEntry)
    }
    
    
    return blogEntries
  }
  
}