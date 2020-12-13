//
//  BookPurchaser.swift
//  SethGodin
//
//  Created by Kraig Spear on 2/23/15.
//  Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import UIKit
import StoreKit


@objc open class BookPurchaser : NSObject, SKStoreProductViewControllerDelegate
{
    let purchaseItem: SGPurchaseItem
    let parentViewController: UIViewController
    let productViewController: SKStoreProductViewController
    let completed: CompletedBlock
    
    public typealias CompletedBlock = ( (_ error:NSError?) -> Void )
    
    public init(purchaseItem: SGPurchaseItem, parentViewController: UIViewController, completed:@escaping CompletedBlock)
    {
        self.completed = completed
        self.purchaseItem = purchaseItem
        self.parentViewController = parentViewController
        self.productViewController = SKStoreProductViewController()
        
        super.init()
        
        self.productViewController.delegate = self
        
    }
    
    open func purchase()
    {
        
        MBProgressHUD.showAdded(to: self.parentViewController.view, animated: true)
        
        let params = [SKStoreProductParameterITunesItemIdentifier : purchaseItem.trackID, SKStoreProductParameterAffiliateToken : "10lKRh"] as [String : Any]
        
        self.productViewController.loadProduct(withParameters: params as [AnyHashable: Any] as! [String : Any], completionBlock: {[weak self] (result, error) -> Void in
            
            if let unwrapSelf = self
            {
                if result
                {
                    unwrapSelf.parentViewController.present(unwrapSelf.productViewController, animated:true, completion:
                    {
                        unwrapSelf.hideHud()
                    })
                }
                else if let unwrapError = error
                {
                    unwrapSelf.hideHud()
                    unwrapSelf.completed(unwrapError as NSError?)
                }
                else
                {
                    unwrapSelf.hideHud()
                }
            }
            
        })
        
    }
    
    fileprivate func hideHud()
    {
         MBProgressHUD.hide(for: self.parentViewController.view, animated: true)
    }
    
    open func productViewControllerDidFinish(_ viewController: SKStoreProductViewController!)
    {
        viewController.dismiss(animated: true) {[weak self] () -> Void in
            if let unwrapSelf = self
            {
                unwrapSelf.completed(nil)
            }
        }
    }
}


