//
//  Shuffle.swift
//  SpearLib
//
//  Created by Kraig Spear on 2/26/15.
//  Copyright (c) 2015 spearware. All rights reserved.
//

import Foundation


extension MutableCollection where Index == Int {
	mutating func shuffle() {
		if count < 2 {return}
		
		for i in startIndex ..< endIndex - 1 {
			let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
			if i != j {
				swap(&self[i], &self[j])
			}
		}
	}
}
