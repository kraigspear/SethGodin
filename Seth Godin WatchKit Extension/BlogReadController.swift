//
//  BlogReadController.swift
//  SethGodin
//
//  Created by Kraig Spear on 5/12/15.
//  Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import Foundation
import WatchKit

class BlogReadController : WKInterfaceController
{
  
  //let onFavoriteSelector : Selector = "onFavorite:"
  
  @IBOutlet weak var blogTitleLabel: WKInterfaceLabel!
  @IBOutlet weak var contentLabel: WKInterfaceLabel!
  
  var blogEntry:BlogEntry?
  
  override func awakeWithContext(context: AnyObject?)
  {
    super.awakeWithContext(context)
    
    if let blogEntry = context as? BlogEntry
    {
      self.blogEntry = blogEntry
      populateBlogEntry(blogEntry)
    }
    
  }
  
  @IBAction func onAddFavorite()
  {
    if let unwrapBlogEntry = blogEntry
    {
      let responder = WatchKitResponder()
      let userInfo = responder.userInfoForSaveFavorite(unwrapBlogEntry.itemId)
      BlogReadController.openParentApplication(userInfo, reply: responder.processLatestBlogEntries)
    }
  }
  
  func populateBlogEntry(blogEntry:BlogEntry)
  {
    self.blogTitleLabel.setText(blogEntry.title)
    
    let data = blogEntry.content.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
    
    let options =
          [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
          NSCharacterEncodingDocumentAttribute : NSUTF8StringEncoding]
    
    let attrStr = NSAttributedString(data: data!, options: options as [NSObject : AnyObject], documentAttributes: nil, error: nil)
    
    self.contentLabel.setText(attrStr?.string)
  }
  
}