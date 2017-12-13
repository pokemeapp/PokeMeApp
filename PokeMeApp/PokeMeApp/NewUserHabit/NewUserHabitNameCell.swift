//
//  NewUserHabitNameCell.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 04..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit

class NewUserHabitNameCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var nameLabel: UITextField!
    var controller: NewUserHabitViewController?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.nameLabel.delegate = self
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let controller = controller else {
            return
        }
        controller.habit?.name = self.nameLabel.text
    }
    
}
