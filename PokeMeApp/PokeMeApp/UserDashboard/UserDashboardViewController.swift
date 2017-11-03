//
//  UserDashboardViewController.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 03..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit

class UserDashboardViewController: UIViewController {

    @IBOutlet var userDashboardMasterView: UserDashboardMasterView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showUserProfile(_ sender: Any) {
        self.performSegue(withIdentifier: Constants.Segues.ShowUserProfile, sender: nil)
    }
    
}
