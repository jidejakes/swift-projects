//  ItemTableViewCell.swift
//  First App
//  Created by jidejakes on 01/08/2018.
//  Copyright © 2018 jidejakes. All rights reserved.

import UIKit

class ItemTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
