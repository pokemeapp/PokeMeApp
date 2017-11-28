//
//  LoginViewController.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 09. 25..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx
import PokeMeKit

class LoginViewController: UIViewController {

    var api: PMAPI!
  
    var masterView: LoginMasterView?
    var loginItems: Variable<[LoginItem]> = Variable([
        LoginItem(key: "Registration.Email".localized),
        LoginItem(key: "Registration.Password".localized),
        ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login.Title".localized
        self.initMasterView()
        self.initObservers()
        self.initRegistrateButton()
        self.initLoginButton()
    }
    
    func initMasterView(){
        guard let masterView: LoginMasterView = self.view as? LoginMasterView else {
            return
        }
        self.masterView = masterView
    }
    
    func initRegistrateButton(){
        self.masterView!.registrateButton.title = "Login.Registrate".localized
        self.masterView!.registrateButton.buttonTapped = { button in
            self.performSegue(withIdentifier: Constants.Segues.ShowRegistration, sender: nil)
        }
    }
    
    func initLoginButton(){
        self.masterView!.loginButton.title = "Login.Login".localized
        
        self.masterView!.loginButton.buttonTapped = { button in
            self.startActivityIndicator()
            
            let email = self.loginItems.value[0].value
            let password = self.loginItems.value[1].value
        
            self.api.login(with: email, and: password) { error in
                self.stopActivityIndicator()
                
                guard error == nil else {
                    return self.displayAlert(title: "Login failed!".localized, message: error!.localizedDescription)
                }
                
                self.dismiss(animated: true, completion: nil)
            }
          
        }
    }
    
}

extension LoginViewController {
    
    func initObservers(){
        self.initBinding()
    }
    
    func initBinding(){
        self.loginItems.asObservable().bind(to: self.masterView!.tableView.rx.items(cellIdentifier: Constants.Cells.LoginItemCell))({(_, model, cell: LoginItemCell) in
            cell.bind(to: model)
        }).addDisposableTo(rx.disposeBag)
    }
    
}

extension LoginViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.ShowRegistration {
            (segue.destination as? RegistrationViewController)?.api = self.api
        }
    }
    
}
