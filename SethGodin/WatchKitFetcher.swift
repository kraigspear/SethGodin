//
//  WatchKitFetcher.swift
//  SethGodin
//
//  Created by Kraig Spear on 5/17/15.
//  Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import Foundation

typealias ReplyBlock =  (([NSObject : AnyObject]!) -> Void)!
/**
*  The logic of passing data between The Apple Watch and iPhone App
*/
@objc public class WatchKitFetcher : NSObject
{
  // MARK:  members
  /// The command and info needed to execute a watch operation.
  private let userInfo:NSDictionary
  
  /// The reply to call after the optation is complete
  private let reply: ReplyBlock
  
  /// Command to fetch blog entries
  public let commandFetch = "fetch"
  public let commandSave = "save"
  /// Value used with commandFetch to indicate what needs to be fetched, the latest entries.
  public let commandParamFetchLatest  = "latest"
  public let commandParamSaveFavorite = "saveFavorite"
  
  /// <#Description#>
  public let numberToFetch = "numberToFetch"
  public let errorKey = "Error"
  public let resultsKey = "results"
  
  private let backgroundTaskName = "fetchLatest"
  
  private let blogGetter = SGCurrentBlogItemsGetter()
  
  private var backgroundTask: UIBackgroundTaskIdentifier?
  
  /// The operation que to run any operations on.
  lazy var operationQue: NSOperationQueue =
  {
    var que = NSOperationQueue()
    que.name = "fetchQue"
    que.maxConcurrentOperationCount = 1
    return que
    }()
  
  // MARK: Init
  init(userInfo:NSDictionary, reply:ReplyBlock)
  {
    self.userInfo = userInfo
    self.reply = reply
  }
  
  // MARK: Background Task
  private func setupBackgroundTask()
  {
    self.backgroundTask = UIApplication.sharedApplication().beginBackgroundTaskWithName(backgroundTaskName, expirationHandler: {[weak self]  () -> Void in
      
      if let strongSelf = self
      {
         strongSelf.blogGetter.cancel()
      }
      
    })
  }
  
  /**
  End the background task. Should be called no matter what
  */
  private func endBackgroundTask()
  {
    dispatch_async(dispatch_get_main_queue())
    {
      if let unwrapTask = self.backgroundTask
      {
         UIApplication.sharedApplication().endBackgroundTask(unwrapTask)
      }
    }
  }
  
  // MARK: Request
  /**
  Process the request from the watch
  */
  public func processRequest()
  {
    if let fetchCommand = self.userInfo[commandFetch] as? String
    {
      if fetchCommand == commandParamFetchLatest
      {
        if let numberToFetch = self.userInfo[numberToFetch] as? NSNumber
        {
          let numberToFetchInt = numberToFetch.integerValue
          fetchLatest(numberToFetchInt)
        }
      }
    }
    else if let saveId = self.userInfo[commandSave] as? String
    {
      saveFavorite(saveId)
    }
  }
  
  /**
  Fetch the latest blog entries
  
  :param: blogCount The number of blog entires to return
  */
  private func fetchLatest(blogCount: Int)
  {
    setupBackgroundTask()
    
    blogGetter.completionBlock = {[weak self] () -> Void in
      
      if let strongSelf = self
      {
        if let error = strongSelf.blogGetter.error
        {
          strongSelf.responseError(error)
        }
        else
        {
          //Note, if we don't get an array of BlogEntry then we need to crash. This would indicate
          //something is wrong in the code. We should get [BlogEntry] back.
          let feedItems = strongSelf.blogGetter.blogEntries as! [SGBlogEntry]
          let feedSubset = strongSelf.extractFeedItemSubset(feedItems, numberToExtract: blogCount)
          strongSelf.reponseBlogEntries(feedSubset)
        }
        //No matter what (error, success ext...) endBackgroundTask needs to be called.
        strongSelf.endBackgroundTask()
      }
    }
    
    self.operationQue.addOperation(blogGetter)
    
  }
  
  private func saveFavorite(blogId: String)
  {
    
  }
  
  /**
  Return just the desiered amout of blog entries
  
  :param: numberToExtract How many blog items should be extracted.
  :param: blogEntries Array of blog items to extract from
  
  :returns: <#return value description#>
  */
  private func extractFeedItemSubset(blogEntries:[SGBlogEntry], numberToExtract: Int) -> [SGBlogEntry]
  {
    if numberToExtract >= blogEntries.count
    {
      return blogEntries
    }
    else
    {
      return Array(blogEntries[0..<numberToExtract])
    }
  }
  
 
  // MARK: Responses
  
  /**
  Send back an error response
  :param: error The error to send back
  */
  private func responseError(error: NSError)
  {
    let errorDict = [errorKey :  self.blogGetter.error]
    dispatch_async(dispatch_get_main_queue())
    {
      self.reply(errorDict)
    }
  }
  
  /**
  Send back a blog entry response
  
  :param: blogEntries The requested blog entries.
  */
  private func reponseBlogEntries(blogEntries: [SGBlogEntry])
  {
    let blogEntryArray = self.blogEntriesToArray(blogEntries)
    let responseDict = [resultsKey : blogEntryArray]
    dispatch_async(dispatch_get_main_queue())
    {
        self.reply(responseDict)
    }
  }
  
  /**
  Convert an array of SGBlogEntry into a Dictionary Array sutiable to the watch kit extension.
  
  :param: blogEntries BlogEntries to convert
  
  :returns: The converted blog entry items
  */
  private func blogEntriesToArray(blogEntries:[SGBlogEntry]) ->  [ [String:AnyObject] ]
  {
    var returnDictionary:[ [String:AnyObject] ] = []
    
    for b in blogEntries
    {
      returnDictionary.append(self.blogEntryToDictionary(b))
    }
    
    return returnDictionary
  }
  
  /**
  Convert a SGBlogEntry to a dictionary that the watch kit extension expects
  You can't return objects. They need to be Arrays, Dictionaries.
  
  :param: blogEntry Blog entry to convert
  
  :returns: The converted blog entry
  */
  private func blogEntryToDictionary(blogEntry:SGBlogEntry) -> [String:AnyObject]
  {
    return ["title" : blogEntry.title,
      "summary" : blogEntry.summary,
      "datePublished" : blogEntry.datePublished,
      "itemId" : blogEntry.itemID,
      "content" : blogEntry.content,
      "urlStr" : blogEntry.urlStr]
  }
  
  
}