//
//  FeedItem.swift
//  SethGodin
//
//  Created by Kraig Spear on 2/25/15.
//  Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import Foundation

public enum FeedType: Int
{
    case BlogEntry = 0
    case PurchaseItem = 1
}

/// An item that is in our activity feed. It can either be a SGBlogEntry or a SGPurchaseItem
@objc public class FeedItem
{
    public let title: String
    public let feedType:FeedType
    public let dataObject: AnyObject

    private init(title: String, feedType:FeedType, dataObject:AnyObject)
    {
        self.title = title
        self.feedType = feedType
        self.dataObject = dataObject
    }

    public var datePublished:NSDate?
    {
        get
        {
            if self.feedType == .BlogEntry
            {
                let blogEntry = self.dataObject as! SGBlogEntry
                return blogEntry.datePublished
            }
            else
            {
                return nil
            }
        }
    }

    public var shareCount:NSNumber?
    {
        get
        {
            if self.feedType == .BlogEntry
            {
                let blogEntry = self.dataObject as! SGBlogEntry
                return blogEntry.shareCount
            }
            else
            {
                return nil
            }
        }
    }

    ///Convert a BlogEntry to a FeedItem
    public class func fromBlogEntry(blogEntry: SGBlogEntry) -> FeedItem
    {
        return FeedItem(title: blogEntry.title, feedType: FeedType.BlogEntry, dataObject: blogEntry)
    }

    ///Convert a PurchaseItem into a FeedItem
    public class func fromPurchaseItem(purchaseItem:SGPurchaseItem) -> FeedItem
    {
        return FeedItem(title: purchaseItem.title, feedType: FeedType.PurchaseItem,  dataObject: purchaseItem)
    }
}

///Load a feed, add additioanl items into the feed such as purchase items
@objc public class FeedLoader : NSObject
{
    ///Provides the feed items
    let blogItemGetter: SGBlogItemsGetter

    public init(blogItemGeter:SGBlogItemsGetter)
    {
        self.blogItemGetter = blogItemGeter
    }

    lazy var fetchQue:NSOperationQueue =
    {
        var que = NSOperationQueue()
        que.name = "fetch"
        que.maxConcurrentOperationCount = 2
        return que
    }()

    public func loadFeed(completed:(feedItems:[FeedItem]?, error:NSError?) -> Void)
    {
        let purchaseItemGetter = SGPurchaseItemGetter()

        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue,
            {
                self.fetchQue.addOperations([purchaseItemGetter, self.blogItemGetter], waitUntilFinished: true)
                
                let purchaseItems = purchaseItemGetter.purchaseItems as! [SGPurchaseItem]
                let blogEntries = self.blogItemGetter.blogEntries as! [SGBlogEntry]
                
                let feedItems = self.feedItemsFrom(purchaseItems:purchaseItems, blogEntries:blogEntries)
                
                dispatch_async(dispatch_get_main_queue(),
                {
                    if purchaseItemGetter.error != nil
                    {
                        completed(feedItems: nil, error: purchaseItemGetter.error)
                    }
                    else if self.blogItemGetter.error != nil
                    {
                        completed(feedItems: nil, error: self.blogItemGetter.error)
                    }
                    else
                    {
                        completed(feedItems: feedItems, error: nil)
                    }
                })
            })
    }

    private func feedItemsFrom(#purchaseItems:[SGPurchaseItem],  blogEntries:[SGBlogEntry]) -> [FeedItem]
    {
        let source = BFTaskCompletionSource()
        
        var feedItems:[FeedItem] = []
        var shuffledPurchaseItems = purchaseItems.shuffled()
        
        var purchaseItemIndex = 0
        
        for i in 0..<blogEntries.count
        {
            let blogEntry = blogEntries[i]
            
            feedItems.append(FeedItem.fromBlogEntry(blogEntry))
            
            if shouldInsertPurchaseItem(atBlogEntryCount: i)
            {
                if stillHavePurchaseItemsToInsert(purchaseItems: shuffledPurchaseItems, index: purchaseItemIndex)
                {
                    let purchaseItem = shuffledPurchaseItems[purchaseItemIndex]
                    
                    feedItems.append(FeedItem.fromPurchaseItem(purchaseItem))
                    
                    purchaseItemIndex++
                }
            }
        }
        
        return feedItems
      }
    
    private func stillHavePurchaseItemsToInsert(#purchaseItems:[SGPurchaseItem], index:Int) -> Bool
    {
        return purchaseItems.count - 1 >= index
    }
    
    private func shouldInsertPurchaseItem(#atBlogEntryCount: Int) -> Bool
    {
        let insertEvery = 3
        let m = atBlogEntryCount % insertEvery
        return m == 0
    }

}
