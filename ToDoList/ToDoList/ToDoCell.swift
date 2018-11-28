//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Silke Knossen on 27/11/2018.
//  Copyright © 2018 Silke Knossen. All rights reserved.
//

import UIKit

@objc protocol ToDoCellDelegate: class {
    func checkmarkTapped(sender: ToDoCell)
}

class ToDoCell: UITableViewCell {
    
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var delegate: ToDoCellDelegate?
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        delegate?.checkmarkTapped(sender: self)
    }
    
}
