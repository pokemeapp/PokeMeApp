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

class LoginViewController: UIViewController {

    var masterView: LoginMasterView?
    var loginItems: Variable<[LoginItem]> = Variable([
        LoginItem(key: "Registration.Username".localized),
        LoginItem(key: "Registration.Email".localized),
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
            print("tapped")
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
