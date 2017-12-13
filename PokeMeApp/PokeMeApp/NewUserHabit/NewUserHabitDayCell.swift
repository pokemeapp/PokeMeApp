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
    var controller: NewUserHabitViewController?
    var days: String = "0000000"{
        didSet {
            self.splitDays(days)
        }
    }
    var boxes: [PMCheckBox] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        boxes = [mondayCheckBox, tuesdayCheckBox, wednesdayCheckBox, thursdayCheckBox, fridayCheckBox, saturdayCheckBox, sundayCheckBox]
    }
    
    func splitDays(_ days: String) {
        var i: Int = 0
        boxes.forEach { (box) in
            if days[i] == "0" {
                box.setCheckState(.unchecked, animated: false)
            }else {
                box.setCheckState(.checked, animated: false)
            }
            i += 1
        }
    }
    
    func getBoxes() -> String{
        var string = ""
        boxes.forEach { (box) in
            string += "\(box.checkState.hashValue)"
        }
        return string
    }

}
extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[Range(start ..< end)])
    }
}
