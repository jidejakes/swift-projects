//  ViewController.swift
//  First App
//  Created by jidejakes on 31/07/2018.
//  Copyright © 2018 jidejakes. All rights reserved.

import UIKit

class ViewController: UIViewController {
	var item: Item?
    @IBOutlet weak var saveButton: UIBarButtonItem!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender as AnyObject? === saveButton {
            let name = nameTextField.text ?? ""
            item = Item(name: name)
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBAction func setLabelText(_ sender: Any) {
        nameLabel.text =
        nameTextField.text
    }
	
    @IBOutlet weak var cancel: UIBarButtonItem!
    @IBAction func cancel(_ sender: UIBarButtonItem) {
		let isinAddMode = presentingViewController is UINavigationController
		if isinAddMode {
			dismiss(animated: true, completion: nil)
		} else {
		_ = navigationController!.popViewController(animated: true)
	}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		if let item = item {
			nameTextField.text = item.name
		}
    }
}
