//
//  MessageOptionsView.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 19..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit

class MessageOptionsView: UIView {
    
    @IBOutlet weak var option1Button: PMButton!
    @IBOutlet weak var option2Button: PMButton!
    @IBOutlet weak var option3Button: PMButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.option1Button.title = "MesageOption1.Title".localized
        self.option2Button.title = "MesageOption2.Title".localized
        self.option3Button.title = "MesageOption3.Title".localized
        self.roundCorners(corners: .allCorners, radius: 5.0)
    }

}
