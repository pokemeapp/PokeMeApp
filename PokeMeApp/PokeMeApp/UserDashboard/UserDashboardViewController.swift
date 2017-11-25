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

class UserDashboardViewController: UIViewController {

    @IBOutlet var userDashboardMasterView: UserDashboardMasterView!
    
    let disposeBag = DisposeBag()
    var userHabits: Variable<[MockHabit]> = Variable([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userDashboardMasterView.tableView.emptyDataSetDataSource = self
        self.userDashboardMasterView.tableView.emptyDataSetDelegate = self
        let mockHabitGenerator: MockHabitGenerator = MockHabitGenerator()
        self.userHabits.value = mockHabitGenerator.createMockHabits(0)
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
