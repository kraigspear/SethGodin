//
// Created by Kraig Spear on 2/17/15.
// Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import Foundation
import CoreData


public class CoreDataBookmarks : NSObject
{
    public typealias CompletedBlock = ( (error:NSError?) -> Void)
    public typealias ExistBlock = ( (exists:Bool) -> Void)

    public func toggleBookmark(blogEntry: SGBlogEntry, complete:CompletedBlock)
    {
        if let bookmarkForEntry = Bookmark.MR_findFirstByAttribute("idStr", withValue: blogEntry.itemID) as? Bookmark
        {
            bookmarkForEntry.MR_deleteEntity()
        }
        else
        {
            if let newBookmark = Bookmark.MR_createEntity() as? Bookmark
            {
              newBookmark.title = blogEntry.title
              newBookmark.datePublished = blogEntry.datePublished
              newBookmark.summary = blogEntry.summary
              newBookmark.url = blogEntry.urlStr
              newBookmark.idStr = blogEntry.itemID
            }
        }
        
        let error = NSErrorPointer()
        
        self.save { (error) -> Void in
            
            if let unwrapError = error
            {
                complete(error: unwrapError)
            }
            else
            {
                complete(error: nil)
            }
        }
        
    }
    
    public func bookmarkExistFor(#blogEntry: SGBlogEntry, success:ExistBlock)
    {
        
        if let bookmarkForEntry = Bookmark.MR_findFirstByAttribute("idStr", withValue: blogEntry.itemID) as? Bookmark
        {
            success(exists: true)
        }
        else
        {
            success(exists: false)
        }
    }
    
    private func save(complete:CompletedBlock) -> Void
    {
        
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreWithCompletion { (success, error) -> Void in
            
            if success
            {
                complete(error:nil)
            }
            else
            {
                complete(error: error)
            }
        }
    }
}
