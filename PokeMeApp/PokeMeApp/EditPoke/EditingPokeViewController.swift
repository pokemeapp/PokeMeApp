//
//  EditingPokeViewController.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 26..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EditingPokeViewController: UIViewController {

    @IBOutlet var masterView: EditingPokeMasterView!
    @IBOutlet weak var editiongPokeViewCenterYConstraint: NSLayoutConstraint!
    
    var userPoke: UserPoke?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        if let userPoke = userPoke {
            
        }else {
            userPoke = UserPoke()
        }
        self.setButtons()
        self.bindComponents()
    }
    
    func setButtons(){
        self.masterView.editingPokeView.saveButton.buttonTapped = { button in
            self.dismiss(animated: true, completion: nil)
        }
        self.masterView.editingPokeView.deleteButton.buttonTapped = { button in
            self.dismiss(animated: true, completion: nil)
        }
        self.masterView.editingPokeView.saveButton.title = "EditingPoke.SaveButton.Title".localized
        self.masterView.editingPokeView.deleteButton.title = "EditingPoke.DeleteButton.Title".localized
    }
    
    func bindComponents(){
        Observable.just(userPoke!.name!).bind(to: self.masterView.editingPokeView.textView.rx.text).addDisposableTo(disposeBag)
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
