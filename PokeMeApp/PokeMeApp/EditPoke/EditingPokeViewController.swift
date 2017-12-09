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
import PokeMeKit

protocol EditingPokeViewControllerDelegate: class {

    func editingPokeController(_ controller: EditingPokeViewController, didAdd pokePrototype: PMPokePrototype)

    func editingPokeController(_ controller: EditingPokeViewController, didSave pokePrototype: PMPokePrototype)

    func editingPokeController(_ controller: EditingPokeViewController, didDelete pokePrototype: PMPokePrototype)

}

class EditingPokeViewController: UIViewController {

    var api: PMAPI!

    @IBOutlet var masterView: EditingPokeMasterView!
    @IBOutlet weak var editiongPokeViewCenterYConstraint: NSLayoutConstraint!
    
    var userPoke: PMPokePrototype!
    let disposeBag = DisposeBag()
    var isUpdate = false

    weak var delegate: EditingPokeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        if let userPoke = userPoke {
            masterView.editingPokeView.textView.text = userPoke.message
            isUpdate = true
        } else {
            userPoke = PMPokePrototype(name: "", message: "")
        }
        self.setButtons()
        self.bindComponents()
    }
    
    func setButtons(){
        self.masterView.editingPokeView.saveButton.buttonTapped = { button in

            self.startActivityIndicator()

            self.userPoke.message = self.masterView.editingPokeView.textView.text
            self.userPoke.name = self.masterView.editingPokeView.textView.text

            if self.isUpdate {
                self.api.put("api/pokes/prototypes/\(self.userPoke.id!)", entity: self.userPoke) { (error, pokePrototype: PMPokePrototype?) in
                    self.stopActivityIndicator()
                    guard error == nil else {
                        self.displayAlert(title: "Error saving poke!", message: error!.localizedDescription)
                        return
                    }

                    self.delegate?.editingPokeController(self, didSave: pokePrototype!)

                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                self.api.post("api/pokes/prototypes", entity: self.userPoke) { (error, pokePrototype: PMPokePrototype?) in
                    self.stopActivityIndicator()
                    guard error == nil else {
                        self.displayAlert(title: "Error saving poke!", message: error!.localizedDescription)
                        return
                    }

                    self.delegate?.editingPokeController(self, didAdd: pokePrototype!)

                    self.dismiss(animated: true, completion: nil)
                }
            }

        }
        self.masterView.editingPokeView.deleteButton.buttonTapped = { button in

            self.startActivityIndicator()

            self.api.delete("api/pokes/prototypes/\(self.userPoke.id!)", entity: self.userPoke) { (error, pokePrototype: PMPokePrototype?) in
                self.stopActivityIndicator()

                guard error == nil else {
                    self.displayAlert(title: "Error deleting poke!", message: error!.localizedDescription)
                    return
                }

                self.delegate?.editingPokeController(self, didDelete: self.userPoke)

                self.dismiss(animated: true, completion: nil)
            }

        }
        self.masterView.editingPokeView.saveButton.title = "EditingPoke.SaveButton.Title".localized
        self.masterView.editingPokeView.deleteButton.title = "EditingPoke.DeleteButton.Title".localized
    }
    
    func bindComponents(){
        //Observable.just(userPoke!.name!).bind(to: self.masterView.editingPokeView.textView.rx.text).addDisposableTo(disposeBag)
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
