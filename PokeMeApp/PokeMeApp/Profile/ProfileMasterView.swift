//
//  ProfileMasterView.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 04..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileMasterView: UIView {
    
    @IBOutlet weak var saveButton: PMButton!
    @IBOutlet weak var logoutButton: PMButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextFiled: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.logoutButton.title = "Profile.LogoutButton.Title".localized
        self.saveButton.title = "Profile.SaveButton.Title".localized
    }
}
