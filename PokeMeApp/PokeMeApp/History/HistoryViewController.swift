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
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    var sections: Variable<[HistorySection]> = Variable([])
    
    var dataSource: RxTableViewSectionedReloadDataSource<HistorySection> = RxTableViewSectionedReloadDataSource<HistorySection>(configureCell: )
    
}
