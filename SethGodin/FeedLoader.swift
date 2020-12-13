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
    case blogEntry = 0
    case purchaseItem = 1
}

/// An item that is in our activity feed. It can either be a SGBlogEntry or a SGPurchaseItem
@objc class FeedItem: NSObject
{
    open let title: String
    open let feedType:FeedType
    open let dataObject: AnyObject

    fileprivate init(title: String, feedType:FeedType, dataObject:AnyObject)
    {
        self.title = title
        self.feedType = feedType
        self.dataObject = dataObject
    }

    open var datePublished:Date?
    {
        get
        {
            if self.feedType == .blogEntry
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

    open var shareCount:NSNumber?
    {
        get
        {
            if self.feedType == .blogEntry
            {
                let blogEntry = self.dataObject as! SGBlogEntry
                return blogEntry.shareCount as NSNumber?
            }
            else
            {
                return nil
            }
        }
    }

    ///Convert a BlogEntry to a FeedItem
    open class func fromBlogEntry(_ blogEntry: SGBlogEntry) -> FeedItem
    {
        return FeedItem(title: blogEntry.title, feedType: FeedType.blogEntry, dataObject: blogEntry)
    }

    ///Convert a PurchaseItem into a FeedItem
    open class func fromPurchaseItem(_ purchaseItem:SGPurchaseItem) -> FeedItem
    {
        return FeedItem(title: purchaseItem.title, feedType: FeedType.purchaseItem,  dataObject: purchaseItem)
    }
}

///Load a feed, add additioanl items into the feed such as purchase items
@objc open class FeedLoader : NSObject
{
    ///Provides the feed items
    let blogItemGetter: SGBlogItemsGetter

    public init(blogItemGetter:SGBlogItemsGetter)
    {
        self.blogItemGetter = blogItemGetter
    }

    lazy var fetchQue:OperationQueue =
    {
        var que = OperationQueue()
        que.name = "fetch"
        que.maxConcurrentOperationCount = 2
        return que
    }()

    func loadFeed(_ completed:@escaping (_ feedItems:[FeedItem]?, _ error:NSError?) -> Void)
    {
        let purchaseItemGetter = SGPurchaseItemGetter()

        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
                //1. Fetch both the purchase items and blog items at the same time.
                
                self.fetchQue.addOperations([purchaseItemGetter, self.blogItemGetter], waitUntilFinished: true)
                
                if let purchaseItems = purchaseItemGetter.purchaseItems as? [SGPurchaseItem]
                {
                   if let blogEntries = self.blogItemGetter.blogEntries as? [SGBlogEntry]
                   {
                       let feedItems = self.feedItemsFrom(purchaseItems:purchaseItems, blogEntries)
                       DispatchQueue.main.async(execute: {
                            completed(feedItems, nil)
                            return
                        })
                   }
                }
                
                //2.
                //If we are able to combine both the purchase items and blog items then we will not be here.
                //At this point there is an error that we need to handle.
                DispatchQueue.main.async(execute: {
                    if purchaseItemGetter.error != nil
                    {
                        completed(nil, purchaseItemGetter.error as NSError?)
                    }
                    else if self.blogItemGetter.error != nil
                    {
                        completed(nil, self.blogItemGetter.error as NSError?)
                    }
                })
            })
    }

    fileprivate func feedItemsFrom(purchaseItems:[SGPurchaseItem],  _ blogEntries:[SGBlogEntry]) -> [FeedItem]
    {
        _ = BFTaskCompletionSource()
        
        var feedItems:[FeedItem] = []
        
        var shuffledPurchaseItems: [SGPurchaseItem] = purchaseItems
        shuffledPurchaseItems.shuffle()
		
        var purchaseItemIndex = 0
        
        for i in 0..<blogEntries.count
        {
            let blogEntry = blogEntries[i]
            
            feedItems.append(FeedItem.fromBlogEntry(blogEntry))
            
			if shouldInsertPurchaseItem(at: i)
            {
                if stillHavePurchaseItemsToInsert(purchaseItems: shuffledPurchaseItems, at: purchaseItemIndex)
                {
                    let purchaseItem = shuffledPurchaseItems[purchaseItemIndex]
                    
                    feedItems.append(FeedItem.fromPurchaseItem(purchaseItem))
                    
                    purchaseItemIndex += 1
                }
            }
        }
        
        return feedItems
      }
    
    fileprivate func stillHavePurchaseItemsToInsert(purchaseItems:[SGPurchaseItem], at: Int) -> Bool
    {
        return purchaseItems.count - 1 >= at
    }
    
    fileprivate func shouldInsertPurchaseItem(at: Int) -> Bool
    {
        let insertEvery = 3
        let m = at % insertEvery
        return m == 0
    }

}
