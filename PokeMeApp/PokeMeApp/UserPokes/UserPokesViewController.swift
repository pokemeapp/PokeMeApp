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

class UserPokesViewController: UIViewController {

    @IBOutlet var masterView: UserPokesMasterView!
    
    let disposeBag = DisposeBag()
    var pokes = Variable([UserPoke(), UserPoke(), UserPoke(), UserPoke()])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initObservers()
        self.initBarButtons()
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
            guard let userPoke = sender as? UserPoke else {
                return
            }
            guard let editingPokeViewController: EditingPokeViewController = segue.destination as? EditingPokeViewController else {
                return
            }
            editingPokeViewController.userPoke = userPoke
        }
    }
    
}


extension UserPokesViewController {
    
    func initObservers(){
        self.pokes.asObservable().bind(to: self.masterView.tableView.rx.items(cellIdentifier: Constants.Cells.UserPokeCell)){(_, model: UserPoke, cell: UserPokeCell) in
            cell.bind(to: model)
        }.addDisposableTo(disposeBag)
        
        self.masterView.tableView.rx.modelSelected(UserPoke.self).subscribe(onNext: { [weak self]model in
            self?.performSegue(withIdentifier: Constants.Segues.ShowEditingPoke, sender: model)
        }).addDisposableTo(disposeBag)
        
    }
    
}
