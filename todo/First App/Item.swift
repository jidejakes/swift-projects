//  Item.swift
//  First App
//  Created by jidejakes on 01/08/2018.
//  Copyright © 2018 jidejakes. All rights reserved.

import Foundation

class Item: NSObject, NSCoding {
	var name: String?
	static let Dir = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
	static let ArchiveURL = Dir.appendingPathComponent("items")
	
	required init(name:String?) {
		self.name = name
	}
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(name, forKey: "name")
	}
	
	required init?(coder aDecoder: NSCoder){
		self.name = aDecoder.decodeObject(forKey: "name") as? String
	}
	
	init(name: String) {
		self.name = name
	}
}
