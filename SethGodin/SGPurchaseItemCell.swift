//
//  SGPurchaseItemCell.swift
//  SethGodin
//
//  Created by Kraig Spear on 3/1/15.
//  Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import UIKit

@objc open class SGPurchaseItemCell : UITableViewCell
{
    fileprivate var _purchaseItem:SGPurchaseItem?
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var bottomImageView: UIImageView!
    
    open override func awakeFromNib() {
        self.contentView.backgroundColor = UIColor(red: 1.0, green: 0.6, blue: 0.0, alpha: 1)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.updateBottomImageView()
    }
    
    fileprivate func updateBottomImageView() {
        bottomImageView.image = UIImage.bottomTableCellForBooks(for: CGSize(width: self.frame.size.width, height: 50))
    }
    
    open var purchaseItem:SGPurchaseItem? {
        set {
            _purchaseItem = newValue
            populateCell()
        }
        get{
            return _purchaseItem
        }
    }
    
    fileprivate func populateCell() {
		guard let purchaseItem = self.purchaseItem else {
			titleLabel.text = ""
			return
		}
		titleLabel.text = purchaseItem.title
		populateImage(from: purchaseItem)
    }
    
    fileprivate func populateImage(from: SGPurchaseItem) {
        self.thumbnailImageView?.image = from.image
    }
}
