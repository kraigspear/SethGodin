//
//  WatchKitResponder.swift
//  SethGodin
//
//  Created by Kraig Spear on 5/23/15.
//  Copyright (c) 2015 AndersonSpear. All rights reserved.
//

import Foundation

typealias ProcessResponse = ( (response:[AnyHashable: Any]?, error:Error? ) )
typealias LatestBlogEntries = ([BlogEntry]?, Error?) -> Void

/**
Processes responses back from the client app

*/
class WatchKitResponder
{
	
	var onBlogEntries:LatestBlogEntries?
	
	// MARK: Latest Blog Entries
	/**
	The code to handle the response coming back from the iPhone App for the latest
	blog entries.
	1. Determine if there is an error
	2. Turn the dictionary to real BlogEntry objects
	3. Give those objects to the caller.
	*/
	func processLatestBlogEntries(_ response: ProcessResponse) -> Void {
		guard let onBlogEntries = self.onBlogEntries else {return}
		
		if let error = response.error {
			onBlogEntries(nil, error)
			return
		}
		
		guard let response = response.response else {return}
		guard let results = response["results"] as? [[String : AnyObject]] else {return}
		
		let blogEntries = convertDictionaryToBlogEntries(results)
		onBlogEntries(blogEntries, nil)
	}
	
	//The request that is needed to get the latest blog entries.
	func userInfoForFetch(_ numberToFetch:Int) -> [AnyHashable: Any]
	{
		return ["fetch" : "latest",
		        "numberToFetch" : numberToFetch]
	}
	
	//Request that a certain blog entry be saved as a favorite
	func userInfoForSaveFavorite(_ blogId:String) -> [AnyHashable: Any]
	{
		return ["favorite" : blogId]
	}
	
	fileprivate func convertDictionaryToBlogEntries(_ resultDictionary:[ [String:AnyObject] ]) -> [BlogEntry]
	{
		var blogEntries: [BlogEntry] = []
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = DateFormatter.Style.short
		
		
		for (_, element) in resultDictionary.enumerated()
		{
			let title = element["title"] as! String
			let date = element["datePublished"] as! Date
			let itemId = element["itemId"] as! String
			let summary = element["summary"] as! String
			let content = element["content"] as! String
			let urlStr = element["urlStr"] as! String
			
			let blogEntry = BlogEntry(itemId: itemId, title: title, summary: summary, content: content, urlStr: urlStr, date: date)
			
			blogEntries.append(blogEntry)
		}
		
		
		return blogEntries
	}
	
}
