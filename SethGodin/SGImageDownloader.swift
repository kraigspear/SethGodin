//
//  SGImageDownloader.swift
//  SethGodin
//
//  Created by Kraig Spear on 4/12/15.
//  Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import UIKit


//Operation to download an image
@objc open class SGImageDownloader : STBaseOperation
{
    
    fileprivate let parseFile: PFFile
    fileprivate let purchaseItem: SGPurchaseItem
    
    public init(purchaseItem:SGPurchaseItem, parseFile: PFFile)
    {
        self.purchaseItem = purchaseItem
        self.parseFile = parseFile
    }
    
    override open func main()
    {
        super.setExecuting(true)
        
        if let data = self.parseFile.getData()
        {
           self.purchaseItem.image = UIImage(data: data);
        }
        
        self.done();
    }
}
