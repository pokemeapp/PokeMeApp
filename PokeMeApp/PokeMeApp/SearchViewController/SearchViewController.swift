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

    var api: PMAPI!

    @IBOutlet var searchUserMasterView: SearchUserMasterView!
    let disposeBag = DisposeBag()
    var users: [PMUser] = []//[PMUser(email: "", firstname: "Zsolt", lastname: "Pete"),
                          //PMUser(email: "", firstname: "Zsolt", lastname: "Pete"),
                          //PMUser(email: "", firstname: "Zsolt", lastname: "Pete")]
    
    var friendRequest: [PMFriendRequest] = []
    var friendRequestUsers: [PMUser] = [PMUser(email: "", firstname: "Viktor", lastname: "Simko"),]
    
    var sections: Variable<[SearchSection]> = Variable([])
    
    var dataSource: RxTableViewSectionedReloadDataSource<SearchSection> = RxTableViewSectionedReloadDataSource<SearchSection>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchUserMasterView.tableView.emptyDataSetDataSource = self
        self.searchUserMasterView.tableView.emptyDataSetDelegate = self
        self.searchUserMasterView.searchHeaderView.searchBar.becomeFirstResponder()
        self.initObservers()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        startActivityIndicator()

        api.get("api/user/friend_requests", query: nil) { (error, friendRequests: [PMFriendRequest]?) in

            self.stopActivityIndicator()

            guard error == nil else {
                self.displayAlert(title: "Error getting friend requests!", message: error!.localizedDescription)
                return
            }

            self.friendRequest = friendRequests!
            self.initSection()
        }
    }

    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func searchUsers(query: String) {
        startActivityIndicator()
        api.get("api/users/search", query: ["query": query]) { (error, users: [PMUser]?) in

            self.stopActivityIndicator()

            guard error == nil else {
                return self.displayAlert(title: "Error fetching results!", message: error!.localizedDescription)
            }

            self.users = users!
            self.initSection()
        }
    }

    func add(friend: PMUser) {
        startActivityIndicator()
        api.post("api/users/\(friend.id!)/send_request", entity: "") { (error, friendRequestResult: String?) in
            self.stopActivityIndicator()

            guard error == nil else {
                self.displayAlert(title: "Error sending friend request", message: error!.localizedDescription)
                return
            }

            self.displayAlert(title: "Friend request sent!", message: "")
        }
    }

    func accept(friendReuquest request: PMFriendRequest) {

    }

    func decline(friendRequest friendRequest: PMFriendRequest) {

    }

}

extension SearchViewController {
    
    func initObservers(){
        self.initSection()
        self.bindSections()
        self.configureCell()
        self.initUserSearch()
    }
    
    func initSection(){
        self.sections.value = [
            SearchSection(header: "Friend request", items: friendRequest),
            SearchSection(header: "Users", items: users),
        ]
    }
    
    
    func configureCell(){
        dataSource.configureCell = { (dataSource, tableView, indexPath, item: Searchable) in
            if indexPath.section == 1 {
                let cell: SearchedUserCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.SearchedUserCell) as! SearchedUserCell
                cell.bind(to: (item as! PMUser))
                cell.addFriend = self.add(friend:)
                return cell
            }else {
                let cell: FriendRequestCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.FriendRequestCell) as! FriendRequestCell
                cell.bind(to: item as! PMFriendRequest)
                return cell
            }
        }
    }
    
    func bindSections(){
        sections.asObservable()
            .bind(to: self.searchUserMasterView.tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
    }

    func initUserSearch() {
        searchUserMasterView.searchHeaderView.searchBar.rx.text.orEmpty
            .asDriver()
            .debounce(1)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .drive(onNext: { [unowned self] query in
                self.searchUsers(query: query)
            }).disposed(by: disposeBag)
    }
}
