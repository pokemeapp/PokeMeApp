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
    
    var api: PMAPI!
    
    let disposeBag = DisposeBag()
    var user = PMUser(email: "petezetep@gmail.com", firstname: "Zsolt", lastname: "Pete")
    
    @IBOutlet var profileMasterView: ProfileMasterView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.profileMasterView.logoutButton.buttonTapped = { [weak self] button in
            self!.logout()
        }
        
        self.profileMasterView.saveButton.buttonTapped = { [weak self] button in
            self!.save()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard api.isLoggedIn else {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let authenticationController = mainStoryboard.instantiateViewController(withIdentifier: "authenticationController")
            let loginController = authenticationController.childViewControllers[0] as! LoginViewController
            loginController.api = api
            
            present(authenticationController, animated: false, completion: nil)
            return
        }
        
        startActivityIndicator()
        
        api.get("api/user") { (error, user: PMUser?) in
            self.stopActivityIndicator()
            
            guard error == nil else {
                self.displayAlert(title: "Error", message: error!.localizedDescription)
                return
            }
            
            self.user = user!
            self.bindComponents()
        }
    }
    
    func save() {
        
        user.firstname = profileMasterView.firstNameTextFiled.text ?? ""
        user.lastname = profileMasterView.lastNameTextField.text ?? ""
        user.email = profileMasterView.emailTextField.text ?? ""
        
        startActivityIndicator()
        api.put("api/user", entity: user) { (error, updatedUser: PMUser?) in
            self.stopActivityIndicator()
            guard error == nil else {
                self.displayAlert(title: "Error", message: error!.localizedDescription)
                return
            }
            
            self.user = updatedUser!
            self.bindComponents()
        }
    }
    
    func logout(){
        api.logout()
        
        tabBarController?.selectedIndex = 0
    }
    
}

extension ProfileViewController {
    
    func bindComponents(){
        Observable.just(self.user.firstname).bind(to: self.profileMasterView.firstNameTextFiled.rx.text).addDisposableTo(disposeBag)
        Observable.just(self.user.lastname).bind(to: self.profileMasterView.lastNameTextField.rx.text).addDisposableTo(disposeBag)
        Observable.just(self.user.email).bind(to: self.profileMasterView.emailTextField.rx.text).addDisposableTo(disposeBag)
    }
    
}
