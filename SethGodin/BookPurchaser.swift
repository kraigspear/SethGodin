//
//  BookPurchaser.swift
//  SethGodin
//
//  Created by Kraig Spear on 2/23/15.
//  Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import UIKit
import StoreKit


@objc public class BookPurchaser : NSObject, SKStoreProductViewControllerDelegate
{
    let purchaseItem: SGPurchaseItem
    let parentViewController: UIViewController
    let productViewController: SKStoreProductViewController
    let completed: CompletedBlock
    
    public typealias CompletedBlock = ( (error:NSError?) -> Void )
    
    public init(purchaseItem: SGPurchaseItem, parentViewController: UIViewController, completed:CompletedBlock)
    {
        self.completed = completed
        self.purchaseItem = purchaseItem
        self.parentViewController = parentViewController
        self.productViewController = SKStoreProductViewController()
        
        super.init()
        
        self.productViewController.delegate = self
        
    }
    
    public func purchase()
    {
        
        MBProgressHUD.showHUDAddedTo(self.parentViewController.view, animated: true)
        
        let params = [SKStoreProductParameterITunesItemIdentifier : purchaseItem.trackID, SKStoreProductParameterAffiliateToken : "10lKRh"]
        
        self.productViewController.loadProductWithParameters(params as [NSObject : AnyObject], completionBlock: {[weak self] (result, error) -> Void in
            
            if let unwrapSelf = self
            {
                if result
                {
                    unwrapSelf.parentViewController.presentViewController(unwrapSelf.productViewController, animated:true, completion:
                    {
                        unwrapSelf.hideHud()
                    })
                }
                else if let unwrapError = error
                {
                    unwrapSelf.hideHud()
                    unwrapSelf.completed(error:unwrapError)
                }
                else
                {
                    unwrapSelf.hideHud()
                }
            }
            
        })
        
    }
    
    private func hideHud()
    {
         MBProgressHUD.hideHUDForView(self.parentViewController.view, animated: true)
    }
    
    public func productViewControllerDidFinish(viewController: SKStoreProductViewController!)
    {
        viewController.dismissViewControllerAnimated(true) {[weak self] () -> Void in
            if let unwrapSelf = self
            {
                unwrapSelf.completed(error: nil)
            }
        }
    }
}


