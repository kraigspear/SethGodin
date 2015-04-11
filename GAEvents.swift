//
// Created by Kraig Spear on 3/22/15.
// Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import Foundation

@objc public class Analytics
{
    public class func logPurchaseTap(bookName: String)
    {
        let dimensions = ["book" : bookName]
        PFAnalytics.trackEvent("purchaseTap", dimensions:dimensions)
    }
    
    public class func logPurchased(bookName: String)
    {
        let dimensions = ["book" : bookName]
        PFAnalytics.trackEvent("purchased", dimensions:dimensions)
    }
    
    public class func logPurchaseError(error:NSError)
    {
        let dimensions = ["description" : error.localizedDescription]
        PFAnalytics.trackEvent("purchaseError", dimensions:dimensions)
    }
    
    public class func logViewBlogToday()
    {
        let dimensions = ["type" : "today"]
        PFAnalytics.trackEvent("viewedBlog", dimensions:dimensions)
    }
    
    public class func logViewBlogNotToday()
    {
        let dimensions = ["type" : "notToday"]
        PFAnalytics.trackEvent("viewedBlog", dimensions:dimensions)
    }
    
}
