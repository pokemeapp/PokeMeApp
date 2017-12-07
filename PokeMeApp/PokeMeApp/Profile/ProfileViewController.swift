//
//  ProfileViewController.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 04..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import PokeMeKit

class ProfileViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    var user = PMUser(email: "petezetep@gmail.com", firstname: "Zsolt", lastname: "Pete")
    
    @IBOutlet var profileMasterView: ProfileMasterView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindComponents()
        self.hideKeyboardWhenTappedAround()
        self.profileMasterView.logoutButton.buttonTapped = { [weak self]utton in
            self!.logout()
        }
    }
    
    func logout(){
        //TODO: Implement logout
    }
    
}

extension ProfileViewController {
    
    func bindComponents(){
        Observable.just(self.user.firstname).bind(to: self.profileMasterView.firstNameTextFiled.rx.text).addDisposableTo(disposeBag)
        Observable.just(self.user.lastname).bind(to: self.profileMasterView.lastNameTextField.rx.text).addDisposableTo(disposeBag)
        Observable.just(self.user.email).bind(to: self.profileMasterView.emailTextField.rx.text).addDisposableTo(disposeBag)
    }
    
}
