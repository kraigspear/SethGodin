//
//  SGImageDownloader.swift
//  SethGodin
//
//  Created by Kraig Spear on 4/12/15.
//  Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import UIKit
import Parse


//Operation to download an image
@objc public class SGImageDownloader : STBaseOperation
{
    
    private let parseFile: PFFile
    private let purchaseItem: SGPurchaseItem
    
    public init(purchaseItem:SGPurchaseItem, parseFile: PFFile)
    {
        self.purchaseItem = purchaseItem
        self.parseFile = parseFile
    }
    
    override public func main()
    {
        super.setExecuting(true)
        
        if let data = self.parseFile.getData()
        {
           self.purchaseItem.image = UIImage(data: data);
        }
        
        self.done();
    }
}
