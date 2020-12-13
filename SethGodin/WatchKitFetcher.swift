//
//  WatchKitFetcher.swift
//  SethGodin
//
//  Created by Kraig Spear on 5/17/15.
//  Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import Foundation

typealias ReplyBlock =  (([AnyHashable: Any]?) -> Void)!
/**
*  The logic of passing data between The Apple Watch and iPhone App
*/
@objc open class WatchKitFetcher : NSObject
{
  // MARK:  members
  /// The command and info needed to execute a watch operation.
  fileprivate let userInfo:NSDictionary
  
  /// The reply to call after the optation is complete
  fileprivate let reply: ReplyBlock
  
  /// Command to fetch blog entries
  open let commandFetch = "fetch"
  open let commandSave = "favorite"
  /// Value used with commandFetch to indicate what needs to be fetched, the latest entries.
  open let commandParamFetchLatest  = "latest"
  open let commandParamSaveFavorite = "saveFavorite"
  
  /// <#Description#>
  open let numberToFetch = "numberToFetch"
  open let errorKey = "Error"
  open let resultsKey = "results"
  
  fileprivate let backgroundTaskName = "fetchLatest"
  
  fileprivate let blogGetter = SGCurrentBlogItemsGetter()
  
  fileprivate var backgroundTask: UIBackgroundTaskIdentifier?
  
  /// The operation que to run any operations on.
  lazy var operationQue: OperationQueue =
  {
    var que = OperationQueue()
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
  fileprivate func setupBackgroundTask()
  {
    self.backgroundTask = UIApplication.shared.beginBackgroundTask(withName: backgroundTaskName, expirationHandler: {[weak self]  () -> Void in
      
      if let strongSelf = self
      {
         strongSelf.blogGetter.cancel()
      }
      
    })
  }
  
  /**
  End the background task. Should be called no matter what
  */
  fileprivate func endBackgroundTask()
  {
    DispatchQueue.main.async
    {
      if let unwrapTask = self.backgroundTask
      {
         UIApplication.shared.endBackgroundTask(unwrapTask)
      }
    }
  }
  
  // MARK: Request
  /**
  Process the request from the watch
  */
  open func processRequest()
  {
    if let fetchCommand = self.userInfo[commandFetch] as? String
    {
      if fetchCommand == commandParamFetchLatest
      {
        if let numberToFetch = self.userInfo[numberToFetch] as? NSNumber
        {
          let numberToFetchInt = numberToFetch.intValue
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
  fileprivate func fetchLatest(_ blogCount: Int)
  {
    setupBackgroundTask()
    
    blogGetter.completionBlock = {[weak self] () -> Void in
      
      if let strongSelf = self
      {
        if let error = strongSelf.blogGetter.error
        {
          strongSelf.responseError(error as NSError)
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
  
  /**
  Save a favorite
  :param: The ID of the blog item to save as a favorite
  */
  fileprivate func saveFavorite(_ blogId: String)
  {
    SGFavoritesParse.addBlogEntrytoFavorites(withId: blogId)
    self.reply(["response":"completed"])
  }
  
  /**
  Return just the desiered amout of blog entries
  
  :param: numberToExtract How many blog items should be extracted.
  :param: blogEntries Array of blog items to extract from
  
  :returns: <#return value description#>
  */
  fileprivate func extractFeedItemSubset(_ blogEntries:[SGBlogEntry], numberToExtract: Int) -> [SGBlogEntry]
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
  fileprivate func responseError(_ error: NSError)
  {
    let errorDict = [errorKey :  self.blogGetter.error]
    DispatchQueue.main.async
    {
      self.reply(errorDict)
    }
  }
  
  /**
  Send back a blog entry response
  
  :param: blogEntries The requested blog entries.
  */
  fileprivate func reponseBlogEntries(_ blogEntries: [SGBlogEntry])
  {
    let blogEntryArray = self.blogEntriesToArray(blogEntries)
    let responseDict = [resultsKey : blogEntryArray]
    DispatchQueue.main.async
    {
        self.reply(responseDict)
    }
  }
  
  /**
  Convert an array of SGBlogEntry into a Dictionary Array sutiable to the watch kit extension.
  
  :param: blogEntries BlogEntries to convert
  
  :returns: The converted blog entry items
  */
  fileprivate func blogEntriesToArray(_ blogEntries:[SGBlogEntry]) ->  [ [String:AnyObject] ]
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
  fileprivate func blogEntryToDictionary(_ blogEntry:SGBlogEntry) -> [String:AnyObject]
  {
    return ["title" : blogEntry.title as AnyObject,
      "summary" : blogEntry.summary as AnyObject,
      "datePublished" : blogEntry.datePublished as AnyObject,
      "itemId" : blogEntry.itemID as AnyObject,
      "content" : blogEntry.content as AnyObject,
      "urlStr" : blogEntry.urlStr as AnyObject]
  }
  
  
}
