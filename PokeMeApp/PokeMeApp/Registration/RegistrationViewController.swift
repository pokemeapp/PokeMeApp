//
//  RegistrationViewController.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 09. 24..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx
import PokeMeKit

class RegistrationViewController: UIViewController {

    var api: PMAPI!
    
    var masterView: RegistrationMasterView?
    var registrationItems: Variable<[RegistrationItem]> = Variable([
        RegistrationItem(key: "Registration.Email".localized),
        RegistrationItem(key: "Registration.Password".localized),
        RegistrationItem(key: "Registration.PasswordAgain".localized),
        RegistrationItem(key: "Registration.FirstName".localized),
        RegistrationItem(key: "Registration.LastName".localized),
        ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Registration.Title".localized
        self.initMasterView()
        self.initObservers()
        self.initRegistrateButton()
    }
    
    func initMasterView(){
        guard let masterView: RegistrationMasterView = self.view as? RegistrationMasterView else {
            return
        }
        self.masterView = masterView
    }
    
    func initRegistrateButton(){
        self.masterView!.registrateButton.title = "Registration.Registrate".localized
        self.masterView!.registrateButton.buttonTapped = { button in
            self.startActivityIndicator()
            
            let email = self.registrationItems.value[0].value
            let firstName = self.registrationItems.value[3].value
            let lastName = self.registrationItems.value[4].value
            let password = self.registrationItems.value[1].value
            let passwordAgain = self.registrationItems.value[2].value
            
            guard password == passwordAgain else {
                return self.displayAlert(title: "Registration failed!".localized, message: "Passwords don't match!".localized)
            }
            
            let user = PMUser(email: email, firstname: firstName, lastname: lastName)
            user.password = password
            
            self.api.register(user) { error in
                self.stopActivityIndicator()
                
                guard error == nil else {
                    return self.displayAlert(title: "Registration failed!".localized, message: error!.localizedDescription)
                }
                
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    


}

extension RegistrationViewController {
    
    func initObservers(){
        self.initBinding()
    }
    
    func initBinding(){
        self.registrationItems.asObservable().bind(to: self.masterView!.tableView.rx.items(cellIdentifier: Constants.Cells.RegistrationItemCell))({(indexPath, model, cell: RegistrationItemCell) in
            cell.bind(to: model)
            if indexPath == 1 || indexPath == 2 {
                cell.inputTextField.isSecureTextEntry = true
            }
        }).addDisposableTo(rx.disposeBag)
    }
    
}
