//
//  ProfileImageView.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 04..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit

class ProfileImageView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialize()
    }
    
    func initialize(){
        self.clipsToBounds = true
        self.addBorder(color: Constants.Colors.Green, width: 1.0)
        self.addShadow(color: Constants.Colors.ShadowGrey, radius: 1.0, opacity: 0.5, offset: CGSize(width: 1.0, height: 1.0))
        self.layer.cornerRadius = self.frame.size.height / 2.0
        self.contentMode = .scaleAspectFill
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = self.frame.size.height / 2.2
    }

}
