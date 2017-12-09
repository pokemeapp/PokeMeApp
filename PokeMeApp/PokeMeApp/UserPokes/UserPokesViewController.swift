//
//  UserPokesViewController.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 26..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PokeMeKit

class UserPokesViewController: UIViewController {

    var api: PMAPI!

    @IBOutlet var masterView: UserPokesMasterView!
    
    let disposeBag = DisposeBag()
    var pokes = Variable([PMPokePrototype]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initObservers()
        self.initBarButtons()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        startActivityIndicator()
        api.get("api/pokes/prototypes") { (error, pokePrototypes: [PMPokePrototype]?) in
            self.stopActivityIndicator()

            guard error == nil else {
                self.displayAlert(title: "Error getting pokes!", message: error!.localizedDescription)
                return
            }

            self.pokes.value = pokePrototypes!
        }
    }

    func initBarButtons(){
        let rightButtonItem = UIBarButtonItem.init(
            title: "UserPokes.AddButton.Title".localized,
            style: .done,
            target: self,
            action: #selector(addButtonTapped)
        )
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    @objc func addButtonTapped(){
        self.performSegue(withIdentifier: Constants.Segues.ShowEditingPoke, sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == Constants.Segues.ShowEditingPoke{

            guard let editingPokeViewController: EditingPokeViewController = segue.destination as? EditingPokeViewController else {
                return
            }

            editingPokeViewController.api = api
            editingPokeViewController.delegate = self

            guard let userPoke = sender as? PMPokePrototype else {
                return
            }

            editingPokeViewController.userPoke = userPoke
        }
    }
    
}


extension UserPokesViewController {
    
    func initObservers(){
        self.pokes.asObservable().bind(to: self.masterView.tableView.rx.items(cellIdentifier: Constants.Cells.UserPokeCell)){(_, model: PMPokePrototype, cell: UserPokeCell) in
            cell.bind(to: model)
        }.addDisposableTo(disposeBag)
        
        self.masterView.tableView.rx.modelSelected(PMPokePrototype.self).subscribe(onNext: { [weak self]model in
            self?.performSegue(withIdentifier: Constants.Segues.ShowEditingPoke, sender: model)
        }).addDisposableTo(disposeBag)
        
    }
    
}

extension UserPokesViewController: EditingPokeViewControllerDelegate {

    func editingPokeController(_ controller: EditingPokeViewController, didAdd pokePrototype: PMPokePrototype) {
        pokes.value.append(pokePrototype)
    }

    func editingPokeController(_ controller: EditingPokeViewController, didSave pokePrototype: PMPokePrototype) {
        let indexOfPoke = pokes.value.index { $0.id == pokePrototype.id }
        pokes.value[indexOfPoke!] = pokePrototype
    }

    func editingPokeController(_ controller: EditingPokeViewController, didDelete pokePrototype: PMPokePrototype) {
        let indexOfPoke = pokes.value.index { $0.id == pokePrototype.id }
        pokes.value.remove(at: indexOfPoke!)
    }

}
