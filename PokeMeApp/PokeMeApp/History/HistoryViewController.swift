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
    
    var histories: [History] = [History(), History(), History(), History()]
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
    }

    func initHistory(){
        self.sections.value = [
            HistorySection(header: "History", items: histories),
        ]
    }
    
    func initTableView(){
        self.masterView.tableView.delegate = nil
        self.masterView.tableView.dataSource = nil
    }
    
    func configureCell(){
        dataSource.configureCell = { dataSource, tableView, indexPath, item in
            if item.isUser! {
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
        self.masterView.collectionView.rx.itemSelected.subscribe(onNext: { pokePrototype in
            //TODO: send poke
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
