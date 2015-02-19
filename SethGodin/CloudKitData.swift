//
//  CloudKitData.swift
//  SethGodin
//
//  Created by Kraig Spear on 2/11/15.
//  Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import Foundation

import CloudKit


public class CloudKitBookmarks: NSObject
{
    let container: CKContainer
    let privateDB: CKDatabase
    
    let blogEntryRecordType = "Favorite"
    let colDatePublished = "DatePublished"
    let colTitle = "Title"
    let colSummary = "Summary"
    let colUrlStr = "UrlStr"
    
    public typealias CompletedBlock = ( (error:NSError?) -> Void)
    public typealias EntryExistBlock = ( (entryExist:Bool, error:NSError?) -> Void)
    
    public override init()
    {
        container = CKContainer.defaultContainer()
        privateDB = container.privateCloudDatabase
        super.init()
    }
    
    public func toggleBookmark(blogEntry: SGBlogEntry, complete:CompletedBlock)
    {
        self.blogItemIsBookMarked(blogEntry, complete: { [weak self] (entryExist, error) -> Void in
            
            if let unwrapSelf = self
            {
                if let unwrapError = error
                {
                    NSLog("ErrorCode = %d", unwrapError.code);
                    complete(error: unwrapError)
                    return
                }
                
                if entryExist
                {
                    unwrapSelf.deleteBlogEntry(blogEntry, completed: complete)
                }
                else
                {
                    unwrapSelf.saveBlogEntry(blogEntry, completed:complete)
                }
            }
        })
    }
    
    private func blogItemIsBookMarked(blogEntry: SGBlogEntry, complete:EntryExistBlock) -> Bool
    {
        let recordId = recordIdForEntry(blogEntry)

        privateDB.fetchRecordWithID(recordId, completionHandler: { (fetchedRecord, error) -> Void in
            
            if let unwrapError = error
            {
                complete(entryExist: false, error: unwrapError)
            }
            else if let unwrapFetched = fetchedRecord
            {
                complete(entryExist: true, error: nil)
            }
        })
        
        return true
    }
    
    private func deleteBlogEntry(blogEntry: SGBlogEntry, completed:CompletedBlock)
    {
        let recordId = recordIdForEntry(blogEntry)
        self.privateDB.deleteRecordWithID(recordId, completionHandler: { (recordId, error) -> Void in
            
            if let unwrapError = error
            {
                completed(error: error)
            }
            else
            {
                completed(error: nil)
            }
            
        })
    }
    
    private func saveBlogEntry(blogEntry: SGBlogEntry, completed:CompletedBlock)
    {
        let recordId = recordIdForEntry(blogEntry)

        let record   = CKRecord(recordType: blogEntryRecordType, recordID:recordId)
        
        record.setObject(blogEntry.datePublished, forKey: colDatePublished)
        record.setObject(blogEntry.title, forKey: colTitle)
        record.setObject(blogEntry.summary, forKey: colSummary)
        record.setObject(blogEntry.urlStr, forKey: colUrlStr)
        
        privateDB.saveRecord(record, completionHandler: { (record, error) -> Void in
            
            if let unwrapError = error
            {
                completed(error: unwrapError)
                return
            }
            
            if let unwrapRecord = record
            {
                 SGNotifications.postFavoriteAdded(blogEntry)
            }
        })
    }
    
    private func recordIdForEntry(blogEntry: SGBlogEntry) -> CKRecordID
    {
        return CKRecordID(recordName: blogEntry.itemID)
    }
}