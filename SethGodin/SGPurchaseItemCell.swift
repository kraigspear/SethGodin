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
    
    @IBOutlet weak var bottomImageView: UIImageView!
    
    public override func awakeFromNib()
    {
        self.contentView.backgroundColor = UIColor(red: 1.0, green: 0.6, blue: 0.0, alpha: 1)
    }
    
    public override func layoutSubviews()
    {
        super.layoutSubviews()
        self.updateBottomImageView()
    }
    
    private func updateBottomImageView()
    {
        self.bottomImageView.image = UIImage.bottomTableCellForBooksForSize(CGSize(width: self.frame.size.width, height: 50))
    }
    
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
            self.populateImage(fromPurchaseItem: unwrapPurchaseItem)
        }
        else
        {
            self.titleLabel.text = ""
        }
    }
    
    private func populateImage(#fromPurchaseItem:SGPurchaseItem)
    {

        fromPurchaseItem.loadImage().continueWithSuccessBlock({[weak self] (task) -> AnyObject! in
            
            if let unwrapSelf = self
            {
                if let unwrapImage = task.result as? UIImage
                {
                    unwrapSelf.thumbnailImageView.image = unwrapImage
                }
            }
            return nil
        })
    }
}
