//
//  SGPurchaseItemCell.swift
//  SethGodin
//
//  Created by Kraig Spear on 3/1/15.
//  Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import UIKit

@objc public class SGPurchaseItemCell : UITableViewCell
{
    private var _purchaseItem:SGPurchaseItem?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    public var purchaseItem:SGPurchaseItem?
    {
        set
        {
            _purchaseItem = newValue
            populateCell()
        }
        get
        {
            return _purchaseItem
        }
    }
    
    private func populateCell()
    {
        if let unwrapPurchaseItem = self.purchaseItem
        {
            self.titleLabel.text = unwrapPurchaseItem.title
        }
        else
        {
           self.titleLabel.text = ""
        }
    }
}
