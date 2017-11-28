//
//  RegistrationItemCell.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 09. 24..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx

class RegistrationItemCell: UITableViewCell {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var keyLabel: UILabel!
    var viewModel: RegistrationItemViewModel = RegistrationItemViewModel()
    
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
        
        self.inputTextField.rx.text.orEmpty.bind(to: viewModel.value).disposed(by: rx.disposeBag)
    }
    
    func bind(to model: RegistrationItem){
        self.viewModel.model = model
    }

}

extension RegistrationItemCell: UITextFieldDelegate {
    
    func setDelegate(){
        self.inputTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}
