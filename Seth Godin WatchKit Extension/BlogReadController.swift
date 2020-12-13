//
//  BlogReadController.swift
//  SethGodin
//
//  Created by Kraig Spear on 5/12/15.
//  Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import Foundation
import WatchKit

final class BlogReadController : WKInterfaceController
{
	
	//let onFavoriteSelector : Selector = "onFavorite:"
	
	@IBOutlet weak var blogTitleLabel: WKInterfaceLabel!
	@IBOutlet weak var contentLabel: WKInterfaceLabel!
	
	var blogEntry:BlogEntry?
	
	override func awake(withContext context: Any?)
	{
		super.awake(withContext: context)
		
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
			let userInfo: [AnyHashable : Any] = responder.userInfoForSaveFavorite(unwrapBlogEntry.itemId)
			
			
			BlogReadController.openParentApplication(userInfo, reply: responder.processLatestBlogEntries)
		}
	}
	
	func populateBlogEntry(_ blogEntry: BlogEntry)
	{
		self.blogTitleLabel.setText(blogEntry.title)
		
		let data: Data = blogEntry.content.data(using: String.Encoding.utf8, allowLossyConversion: true)!
		
		let options: [String : Any] =
			[NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
			 NSCharacterEncodingDocumentAttribute : String.Encoding.utf8] as [String : Any]
		
		let attrStr: NSAttributedString = try! NSAttributedString(data: data, options: options, documentAttributes: nil)
		
		
		self.contentLabel.setText(attrStr.string)
	}
	
}
