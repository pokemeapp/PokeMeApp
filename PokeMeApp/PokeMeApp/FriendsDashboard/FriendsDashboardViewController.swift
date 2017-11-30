//
//  FriendsDashboardViewController.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 14..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import PokeMeKit

class FriendsDashboardViewController: UIViewController, UISearchControllerDelegate {

    var api: PMAPI!
    let disposeBag = DisposeBag()
    var friends: Variable<[PMUser]> = Variable([])
    
    @IBOutlet var masterView: FriendsDashboardMasterView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.masterView.tableView.emptyDataSetDataSource = self
        self.masterView.tableView.emptyDataSetDelegate = self
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        self.navigationItem.searchController?.delegate = self
//        let mockHabitGenerator: MockHabitGenerator = MockHabitGenerator()
//        self.userHabits.value = mockHabitGenerator.createMockHabits(2)
        self.initObservers()
        self.title = "FriendsrDashsboard.Title".localized
        
        self.api.get("api/user/friends") { (error, friends: [PMFriend]?) in
            guard error == nil else {
                return self.displayAlert(title: "Error retrieving data", message: error!.localizedDescription)
            }
            
            guard let friends = friends else {
                return
            }
            
            self.friends.value = friends.map { $0.owner }.flatMap { $0 }
        }
    }
    
    func testBase64(){
        let encodedImageData = Constants.Base64.Test
        let imageData = Data(base64Encoded: encodedImageData, options: .ignoreUnknownCharacters)
        let image = UIImage(data: imageData!)
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        self.performSegue(withIdentifier: Constants.Segues.ShowSearch, sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.ShowMessagingPopUp {
            guard let habit = sender as? PMUser else {
                return
            }
            guard let viewControlletr = segue.destination as? MessagingPopUpViewController else {
                return
            }
            //viewControlletr.mockHabit = habit
        }
    }
    
}

extension FriendsDashboardViewController {
    
    func initObservers(){
        self.friends.asObservable().bind(to: self.masterView.tableView.rx.items(cellIdentifier: Constants.Cells.FriendCell))({ (_, model: PMUser, cell: FriendCell) in
            cell.buttonTapped = { [weak self] button in
                self!.performSegue(withIdentifier: Constants.Segues.ShowMessagingPopUp, sender: model)
            }
            cell.bind(to: model)
        }).addDisposableTo(disposeBag)
        self.masterView.tableView.rx.itemSelected.subscribe(onNext:{ _ in
            self.performSegue(withIdentifier: Constants.Segues.ShowHistory, sender: nil)
        }).addDisposableTo(disposeBag)
    }
    
}
