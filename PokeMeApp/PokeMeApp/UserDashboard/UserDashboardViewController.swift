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

class UserDashboardViewController: UIViewController {

    @IBOutlet var userDashboardMasterView: UserDashboardMasterView!
    
    let disposeBag = DisposeBag()
    var userHabits: Variable<[MockHabit]> = Variable([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mockHabitGenerator: MockHabitGenerator = MockHabitGenerator()
        self.userHabits.value = mockHabitGenerator.createMockHabits(5)
        self.initObservers()
    }
    
    @IBAction func showUserProfile(_ sender: Any) {
        self.performSegue(withIdentifier: Constants.Segues.ShowUserProfile, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.ShowUserHabit {
            guard let habit: MockHabit = sender as? MockHabit else {
                return
            }
            guard let newUserHabitViewController: NewUserHabitViewController = segue.destination as? NewUserHabitViewController else {
                return
            }
            newUserHabitViewController.habit = habit
        }
    }
    
}

extension UserDashboardViewController {
    
    func initObservers(){
        self.userHabits.asObservable().bind(to: self.userDashboardMasterView.tableView.rx.items(cellIdentifier: Constants.Cells.UserHabitCell))({ (_, model: MockHabit, cell: UserHabitCell) in
            cell.bind(to: model)
        }).addDisposableTo(disposeBag)
        self.userDashboardMasterView.tableView.rx.modelSelected(MockHabit.self).subscribe(onNext: { [weak self]model in
            self?.performSegue(withIdentifier: Constants.Segues.ShowUserHabit, sender: model)
        }).addDisposableTo(disposeBag)
    }
    
}
