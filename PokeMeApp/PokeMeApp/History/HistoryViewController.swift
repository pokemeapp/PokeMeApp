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

class HistoryViewController: UIViewController {

    @IBOutlet var masterView: HistoryMasterView!
    
    var sections: Variable<[HistorySection]> = Variable([])
    
    var dataSource: RxTableViewSectionedReloadDataSource<HistorySection> = RxTableViewSectionedReloadDataSource<HistorySection>()
    
    var histories: [History] = [History(), History(), History(), History()]
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        initHistory()
        initTableView()
        configureCell()
        bindSections()
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
    
}
