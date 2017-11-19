//
//  CustomMessageView.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 19..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit

class CustomMessageView: UIView {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendButton: PMButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.sendButton.title = "CustomMessage.Title".localized
        self.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 5.0)
    }
    
}
