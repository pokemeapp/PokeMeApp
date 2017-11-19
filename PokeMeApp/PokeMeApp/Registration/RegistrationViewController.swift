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

class RegistrationViewController: UIViewController {

    var masterView: RegistrationMasterView?
    var registrationItems: Variable<[RegistrationItem]> = Variable([
        RegistrationItem(key: "Registration.Username".localized),
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
            print("tapped")
        }
    }

}

extension RegistrationViewController {
    
    func initObservers(){
        self.initBinding()
    }
    
    func initBinding(){
        self.registrationItems.asObservable().bind(to: self.masterView!.tableView.rx.items(cellIdentifier: Constants.Cells.RegistrationItemCell))({(_, model, cell: RegistrationItemCell) in
            cell.bind(to: model)
        }).addDisposableTo(rx.disposeBag)
    }
    
}
