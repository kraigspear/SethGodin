//
// Created by Kraig Spear on 3/22/15.
// Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import Foundation

@objc public class GAEvents
{
    public class func logPurchaseTap(bookName: String)
    {
        let event = GAIDictionaryBuilder.createEventWithCategory("Purchase", action: "purchaseSelected", label: bookName, value: nil).build()
        
        GAI.sharedInstance().defaultTracker.send(event)
    }
    
    public class func logPurchased(bookName: String)
    {
        let event = GAIDictionaryBuilder.createEventWithCategory("Purchase", action: "purchased", label: bookName, value: nil).build()
        
        GAI.sharedInstance().defaultTracker.send(event)
    }
    
    public class func logPurchaseError(error:NSError)
    {
        let event = GAIDictionaryBuilder.createEventWithCategory("Purchase", action: "error", label: error.localizedDescription, value: nil).build()
        
        GAI.sharedInstance().defaultTracker.send(event)
    }

    
    public class func logViewBlogToday()
    {
        let event = GAIDictionaryBuilder.createEventWithCategory("BlogEntry", action: "Viewed", label: "Today", value: nil).build()
        
        GAI.sharedInstance().defaultTracker.send(event)
    }
    
    public class func logViewBlogNotToday()
    {
        let event = GAIDictionaryBuilder.createEventWithCategory("BlogEntry", action: "Viewed", label: "NotToday", value: nil).build()
        
        GAI.sharedInstance().defaultTracker.send(event)
    }
    
}
