//
//  NewUserHabitDescriptionsCell.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 04..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit

class NewUserHabitDescriptionsCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var descriptionLabel: UITextView!
    var controller: NewUserHabitViewController?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.descriptionLabel.delegate = self
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let controller = controller else {
            return
        }
        controller.habit?.description = self.descriptionLabel.text
    }

}
