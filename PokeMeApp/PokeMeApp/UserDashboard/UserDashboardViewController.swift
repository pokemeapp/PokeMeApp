//
//  UserDashboardViewController.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 03..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import TBEmptyDataSet
import PokeMeKit

class UserDashboardViewController: UIViewController {

    @IBOutlet var userDashboardMasterView: UserDashboardMasterView!
    
    var api: PMAPI!
    let disposeBag = DisposeBag()
    var userHabits: Variable<[PMHabit]> = Variable([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userDashboardMasterView.tableView.emptyDataSetDataSource = self
        self.userDashboardMasterView.tableView.emptyDataSetDelegate = self
        self.initObservers()
        self.title = "UserDashsboard.Title".localized
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard api.isLoggedIn else {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let authenticationController = mainStoryboard.instantiateViewController(withIdentifier: "authenticationController")
            let loginController = authenticationController.childViewControllers[0] as! LoginViewController
            loginController.api = api
            
            present(authenticationController, animated: false, completion: nil)
            return
        }


        startActivityIndicator()
        api.get("api/habits", query: nil) { (error, habits: [PMHabit]?) in

            self.stopActivityIndicator()

            guard error == nil else {
                self.displayAlert(title: "Error getting habits!", message: error!.localizedDescription)
                return
            }

            self.userHabits.value = habits!
        }
    }
    
    @IBAction func showUserProfile(_ sender: Any) {
        self.performSegue(withIdentifier: Constants.Segues.ShowUserPokes, sender: nil)
    }
    @IBAction func addNewHabit(_ sender: Any) {
        self.performSegue(withIdentifier: Constants.Segues.ShowUserHabit, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.ShowUserHabit {
            guard let newUserHabitViewController: NewUserHabitViewController = segue.destination as? NewUserHabitViewController else {
                return
            }
            newUserHabitViewController.api = api
            guard let habit: PMHabit = sender as? PMHabit else {
                return
            }
            newUserHabitViewController.habit = habit
        } else if segue.identifier == Constants.Segues.ShowUserPokes {
            guard let userPokesController = segue.destination as? UserPokesViewController else {
                return
            }

            userPokesController.api = api
        }
    }
    
    func doneAction(_ model: PMHabit){
        startActivityIndicator()
        api.post("api/habits/\(model.id!)/done", entity: "") { (error, response: String?) in

            self.stopActivityIndicator()

            guard error == nil else {
                self.displayAlert(title: "Error doing habit!", message: error!.localizedDescription)
                return
            }

        }
    }
    
    func snoozeAction(_ model: PMHabit){
        startActivityIndicator()
        api.post("api/habits/\(model.id!)/reject", entity: "") { (error, response: String?) in

            self.stopActivityIndicator()

            guard error == nil else {
                self.displayAlert(title: "Error snoozing habit!", message: error!.localizedDescription)
                return
            }

        }
        LocalPushManager.shared.setUpLocalNotification(message: model.description!, hm: model.hour!)
    }
    
}

extension UserDashboardViewController {
    
    func initObservers(){
        self.userHabits.asObservable().bind(to: self.userDashboardMasterView.tableView.rx.items(cellIdentifier: Constants.Cells.UserHabitCell))({ (_, model: PMHabit, cell: UserHabitCell) in
            cell.bind(to: model)
            cell.userHabitCellView.doneButton.buttonTapped = { [weak self]button in
                self!.doneAction(model)
            }
            cell.userHabitCellView.snoozeButton.buttonTapped = { [weak self]button in
                self!.snoozeAction(model)
            }
        }).addDisposableTo(disposeBag)
        self.userDashboardMasterView.tableView.rx.modelSelected(PMHabit.self).subscribe(onNext: { [weak self]model in
            self?.performSegue(withIdentifier: Constants.Segues.ShowUserHabit, sender: model)
        }).addDisposableTo(disposeBag)
    }
    
}


extension UIViewController: TBEmptyDataSetDelegate, TBEmptyDataSetDataSource {
    
    public func customViewForEmptyDataSet(in scrollView: UIScrollView) -> UIView? {
        let view = EmptyDataSet(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        //TOdo: Make it localized
        view.title = "No content"
        return view
    }
    
    public func emptyDataSetTapEnabled(in scrollView: UIScrollView) -> Bool {
        return true
    }
    
    public func emptyDataSetDidTapEmptyView(in scrollView: UIScrollView) {
        print("Tapped")
    }
    
}
