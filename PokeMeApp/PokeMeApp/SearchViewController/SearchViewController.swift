//
//  SearchViewController.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 14..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import TBEmptyDataSet

class SearchViewController: UIViewController {

    @IBOutlet var searchUserMasterView: SearchUserMasterView!
    let disposeBag = DisposeBag()
    var mockUsers: Variable<[MockUser]> = Variable([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchUserMasterView.tableView.emptyDataSetDataSource = self
        self.searchUserMasterView.tableView.emptyDataSetDelegate = self
        self.searchUserMasterView.searchHeaderView.searchController.becomeFirstResponder()
        let mockUserGenerator = MockUserGenerator(options: [.imageURL, .firstName, .lastName, .fullName])
        self.mockUsers.value = mockUserGenerator.createMockUsers(0)
        self.initObservers()
    }
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SearchViewController {
    
    func initObservers(){
        self.initTableView()
    }
    
    func initTableView(){
        self.mockUsers.asObservable().bind(to: self.searchUserMasterView.tableView.rx.items(cellIdentifier: Constants.Cells.SearchedUserCell))({(_, model, cell: SearchedUserCell) in
            cell.bind(to: model)
        }).addDisposableTo(disposeBag)
    }
    
}
