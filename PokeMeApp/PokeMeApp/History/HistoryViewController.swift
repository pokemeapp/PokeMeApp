//
//  HistoryViewController.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 26..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import PokeMeKit

class HistoryViewController: UIViewController {

    @IBOutlet var masterView: HistoryMasterView!
    
    var sections: Variable<[HistorySection]> = Variable([])
    
    var dataSource: RxTableViewSectionedReloadDataSource<HistorySection> = RxTableViewSectionedReloadDataSource<HistorySection>()

    var friendId: Int!
    var history: [PMPoke] = []
    var api: PMAPI!
    var pokes = Variable([PMPokePrototype]())
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        initHistory()
        initTableView()
        configureCell()
        bindSections()
        initCollectionView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startActivityIndicator()
        api.get("api/pokes/prototypes", query: nil) { (error, pokePrototypes: [PMPokePrototype]?) in
            self.stopActivityIndicator()
            
            guard error == nil else {
                self.displayAlert(title: "Error getting pokes!", message: error!.localizedDescription)
                return
            }
            
            self.pokes.value = pokePrototypes!
        }

        self.updateHistory()
    }

    func updateHistory() {
        startActivityIndicator()
        api.get("api/pokes/\(friendId!)", query: nil) { (error, pokes: [PMPoke]?) in

            guard error == nil else {
                self.displayAlert(title: "Error getting history!", message: error!.localizedDescription)
                self.stopActivityIndicator()
                return
            }

            self.history = pokes!

            self.updatePokePrototypes()
        }

    }

    func updatePokePrototypes() {

        let pokeUpdateGroup = DispatchGroup()

        for poke in self.history {
            pokeUpdateGroup.enter()

            startActivityIndicator()
            self.api.get("api/pokes/prototypes/\(poke.prototype_id!)") { (error, prototype: PMPokePrototype?) in
                pokeUpdateGroup.leave()

                guard error == nil else {
                    self.displayAlert(title: "Error getting poke prototypes!", message: error!.localizedDescription)
                    self.stopActivityIndicator()
                    self.history = []
                    return
                }

                poke.prototype = prototype
            }

        }

        pokeUpdateGroup.notify(queue: .main) {
            self.stopActivityIndicator()
            self.initHistory()
        }

    }

    func send(pokePrototype: PMPokePrototype) {
        let poke = PMPoke()
        poke.target_id = friendId

        startActivityIndicator()
        self.api.post("api/pokes/prototypes/\(pokePrototype.id!)/send", entity: poke) { (error, poke: PMPoke?) in
            self.stopActivityIndicator()
            guard error == nil else {
                self.displayAlert(title: "Error sending poke!", message: error!.localizedDescription)
                return
            }

        }
    }

    func initHistory(){
        self.sections.value = [
            HistorySection(header: "History", items: history),
        ]
    }
    
    func initTableView(){
        self.masterView.tableView.delegate = nil
        self.masterView.tableView.dataSource = nil
    }
    
    func configureCell(){
        dataSource.configureCell = { dataSource, tableView, indexPath, item in
            if item.target_id == self.friendId {
                let cell: UserHistoryCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.UserHistoryCell) as! UserHistoryCell
                cell.bind(to: item)
                return cell
            }else {
                let cell: PartnerHistoryCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.PartnerHistoryCell) as! PartnerHistoryCell
                cell.bind(to: item)
                return cell
            }
        }
    }
    
    func bindSections(){
        sections.asObservable()
            .bind(to: self.masterView.tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
    }
    
    func initCollectionView(){
        self.pokes.asObservable().bind(to: self.masterView.collectionView.rx.items(cellIdentifier: Constants.Cells.PokeHistoryCell)){ (index, model: PMPokePrototype, cell: PokeHistoryCell) in
            cell.bind(to: model)
        }.addDisposableTo(disposeBag)
        self.masterView.collectionView.rx.modelSelected(PMPokePrototype.self).subscribe(onNext: { pokePrototype in
            self.send(pokePrototype: pokePrototype)
        }).addDisposableTo(disposeBag)
    }
    @IBAction func yesButtonTapped(_ sender: Any) {
        //TODO: Server calling
        guard let button = sender as? UIButton else {
            return
        }
        button.setTitleColor(Constants.Colors.Green, for: .normal)
    }
    
    @IBAction func noButtonTapped(_ sender: Any) {
        //TODO: Server calling
        guard let button = sender as? UIButton else {
            return
        }
        button.setTitleColor(Constants.Colors.Green, for: .normal)
    }
    
}
