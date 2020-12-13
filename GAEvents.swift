//
// Created by Kraig Spear on 3/22/15.
// Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import Foundation

open class Analytics
{
    open class func logPurchaseTap(_ bookName: String)
    {
        let dimensions = ["book" : bookName]
        PFAnalytics.trackEvent("purchaseTap", dimensions:dimensions)
    }
    
    open class func logPurchased(_ bookName: String)
    {
        let dimensions = ["book" : bookName]
        PFAnalytics.trackEvent("purchased", dimensions:dimensions)
    }
    
    open class func logPurchaseError(_ error:NSError)
    {
        let dimensions = ["description" : error.localizedDescription]
        PFAnalytics.trackEvent("purchaseError", dimensions:dimensions)
    }
    
    open class func logViewBlogToday()
    {
        let dimensions = ["type" : "today"]
        PFAnalytics.trackEvent("viewedBlog", dimensions:dimensions)
    }
    
    open class func logViewBlogNotToday()
    {
        let dimensions = ["type" : "notToday"]
        PFAnalytics.trackEvent("viewedBlog", dimensions:dimensions)
    }
    
}
