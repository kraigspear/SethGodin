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
                let blogEntry = self.dataObject as SGBlogEntry
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
                let blogEntry = self.dataObject as SGBlogEntry
                return blogEntry.shareCount
            }
            else
            {
                return nil
            }
        }
    }
    
    public class func fromBlogEntry(blogEntry: SGBlogEntry) -> FeedItem
    {
       
        return FeedItem(title: blogEntry.title, feedType: FeedType.BlogEntry, dataObject: blogEntry)
    }
    
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

    public func loadFeed() -> BFTask
    {
        return self.loadContent()
    }

    private func loadContent() -> BFTask
    {
        return self.blogItemGetter.requestItems().continueWithSuccessBlock {(task) -> AnyObject! in
            
            let blogEntries = task.result as [SGBlogEntry]
            return self.insertBooks(intoEntries: blogEntries)
        }
    }
    
    
    ///Once a feed has been loaded, books to purchase are added
    private func insertBooks(#intoEntries:[SGBlogEntry]) -> BFTask
    {
        return latestFromITunes().continueWithSuccessBlock {  (task) -> AnyObject! in
            
            let purchaseItems = task.result as [SGPurchaseItem]
            
            return self.feedItemsFrom(purchaseItems: purchaseItems, blogEntries: intoEntries)
        }
    }
    
    private func feedItemsFrom(#purchaseItems:[SGPurchaseItem],  blogEntries:[SGBlogEntry]) -> BFTask
    {
        let source = BFTaskCompletionSource()
        
        var feedItems:[FeedItem] = []
        var sortedPurchaseItems = purchaseItems
        
        sortedPurchaseItems.shuffle()
        
        var purchaseItemIndex = 0
        
        for i in 0..<blogEntries.count
        {
            let blogEntry = blogEntries[i]
            
            feedItems.append(FeedItem.fromBlogEntry(blogEntry))
            
            if shouldInsertPurchaseItem(atBlogEntryCount: i)
            {
                if stillHavePurchaseItemsToInsert(purchaseItems: sortedPurchaseItems, index: purchaseItemIndex)
                {
                    let purchaseItem = purchaseItems[purchaseItemIndex]
                    
                    feedItems.append(FeedItem.fromPurchaseItem(purchaseItem))
                    
                    purchaseItemIndex++
                }
            }
        }
        
        source.setResult(feedItems)
        
        return source.task
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
    
    private func latestFromITunes() -> BFTask
    {
        let purchaseItemGetter = SGPurchaseItemGetter()
        return purchaseItemGetter.latestFromiTunes()
    }
}