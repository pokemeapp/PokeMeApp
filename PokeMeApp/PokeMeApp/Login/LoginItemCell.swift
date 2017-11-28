//
//  LoginItemCell.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 09. 25..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx

class LoginItemCell: UITableViewCell {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var keyLabel: UILabel!
    var viewModel: LoginItemViewModel = LoginItemViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setDelegate()
        self.bindComponents()
    }
    
    func bindComponents(){
        self.viewModel.key.asObservable().map{$0 + ":"}.bind(to: self.keyLabel.rx.text).addDisposableTo(rx.disposeBag)
        self.viewModel.key.asObservable().map{$0.localized.lowercased()}.subscribe(onNext: { [weak self]placeholder in
            self?.inputTextField.placeholder = placeholder
        }).addDisposableTo(rx.disposeBag)
        
        self.inputTextField.rx.text.orEmpty.bind(to: self.viewModel.value).disposed(by: rx.disposeBag)
    }
    
    func bind(to model: LoginItem){
        self.viewModel.model = model
    }

}

extension LoginItemCell: UITextFieldDelegate {
    
    func setDelegate(){
        self.inputTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}
