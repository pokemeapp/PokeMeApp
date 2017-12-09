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
import RxDataSources
import PokeMeKit

class SearchViewController: UIViewController {

    @IBOutlet var searchUserMasterView: SearchUserMasterView!
    let disposeBag = DisposeBag()
    var users: [PMUser] = [PMUser(email: "", firstname: "Zsolt", lastname: "Pete"),
                           PMUser(email: "", firstname: "Zsolt", lastname: "Pete"),
                           PMUser(email: "", firstname: "Zsolt", lastname: "Pete")]
    
    var friendRequest: [PMFriendRequest] = []
    var friendRequestUsers: [PMUser] = [PMUser(email: "", firstname: "Viktor", lastname: "Simko"),]
    
    var sections: Variable<[SearchSection]> = Variable([])
    
    var dataSource: RxTableViewSectionedReloadDataSource<SearchSection> = RxTableViewSectionedReloadDataSource<SearchSection>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchUserMasterView.tableView.emptyDataSetDataSource = self
        self.searchUserMasterView.tableView.emptyDataSetDelegate = self
        self.searchUserMasterView.searchHeaderView.searchController.becomeFirstResponder()
        self.initObservers()
    }
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SearchViewController {
    
    func initObservers(){
        self.initSection()
        self.bindSections()
        self.configureCell()
    }
    
    func initSection(){
        self.sections.value = [
            //TODO: @aqviktor: Use friendRequest array not friendRequestUsers
            SearchSection(header: "Friend request", items: friendRequestUsers),
            SearchSection(header: "Users", items: users),
        ]
    }
    
    
    func configureCell(){
        dataSource.configureCell = { (dataSource, tableView, indexPath, item: Searchable) in
            if indexPath.section == 1 {
                let cell: SearchedUserCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.SearchedUserCell) as! SearchedUserCell
                cell.bind(to: (item as! PMUser))
                return cell
            }else {
                let cell: FriendRequestCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.FriendRequestCell) as! FriendRequestCell
                //TODO: @aqviktor: Swap comment in the next two lines
                cell.bind(to: (item as! PMUser))
                //cell.bind(to: (item as! PMFriendRequest).owner!)
                return cell
            }
        }
    }
    
    func bindSections(){
        sections.asObservable()
            .bind(to: self.searchUserMasterView.tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
    }
    
}
