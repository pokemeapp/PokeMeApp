//
//  NewUserHabitDayCell.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 04..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit

class NewUserHabitDayCell: UITableViewCell {

    @IBOutlet weak var mondayCheckBox: PMCheckBox!
    @IBOutlet weak var tuesdayCheckBox: PMCheckBox!
    @IBOutlet weak var wednesdayCheckBox: PMCheckBox!
    @IBOutlet weak var thursdayCheckBox: PMCheckBox!
    @IBOutlet weak var fridayCheckBox: PMCheckBox!
    @IBOutlet weak var saturdayCheckBox: PMCheckBox!
    @IBOutlet weak var sundayCheckBox: PMCheckBox!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
