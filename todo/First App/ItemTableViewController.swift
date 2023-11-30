//  ItemTableViewController.swift
//  First App
//  Created by jidejakes on 01/08/2018.
//  Copyright © 2018 jidejakes. All rights reserved.

import UIKit
class ItemTableViewController: UITableViewController {
	
var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		if let savedItems = loadItem(){
			items += savedItems
		}
    }
	
	func saveItems(){
		let isSaved = NSKeyedArchiver.archiveRootObject(items, toFile: Item.ArchiveURL.path)
		if !isSaved {
			print("Failed to save items.")
		}
	}
	
	func loadItem() -> [Item]? {
		return NSKeyedUnarchiver.unarchiveObject(
			withFile: Item.ArchiveURL.path) as? [Item]
	}
	
	var item: Item?
	@IBAction func unwindToList(sender: UIStoryboardSegue) {
		let srcViewCon = sender.source as?ViewController
		let item = srcViewCon?.item
		if (srcViewCon != nil && item?.name != "") {
			if let selectedIndexPath = tableView.indexPathForSelectedRow{
				items[selectedIndexPath.row] = item!
				tableView.reloadRows(at: [selectedIndexPath], with: .none)
			}
			else{
			let newIndexPath = NSIndexPath(row: items.count, section: 0)
			items.append(item!)
			tableView.insertRows(at: [newIndexPath as IndexPath], with: UITableViewRowAnimation.bottom)
		}
			saveItems()
	}
	}

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cellIdentifier = "ItemTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as!ItemTableViewCell
		let item = items[indexPath.row]
		cell.nameLabel.text = item.name
        return cell
    }
	
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
			items.remove(at: indexPath.row)
			saveItems()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
		if segue.identifier == "showDetail" {
			let detailVC = segue.destination as? ViewController
			//Get the cell that generated this segue
			if let selectedCell = sender as? ItemTableViewCell {
				let indexPath = tableView.indexPath(for: selectedCell)!
				let selectedItem = items[indexPath.row]
				detailVC?.item = selectedItem
			}
		} else if segue.identifier == "addItem" {
		}
}
}
