//
//  NewUserHabitViewController.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 04..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class NewUserHabitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var pickerViewBottomConstraint: NSLayoutConstraint!
    let disposeBag = DisposeBag()
    @IBOutlet var newUserHabitMasterView: NewUserHabitMasterView!
    var habit: MockHabit?
    var headerTitles: [String] = ["UserHabitSectionName".localized, "UserHabitSectionDescription".localized, "UserHabitSectionDate".localized]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newUserHabitMasterView.tableView.dataSource = self
        self.newUserHabitMasterView.tableView.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: NewUserHabitNameCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.NewUserHabitNameCell, for: indexPath) as! NewUserHabitNameCell
            cell.nameLabel.text = habit?.name ?? ""
            return cell
        }else if indexPath.section == 1 {
            let cell: NewUserHabitDescriptionsCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.NewUserHabitDescriptionsCell, for: indexPath) as! NewUserHabitDescriptionsCell
            cell.descriptionLabel.text = habit?.habitDescription ?? ""
            return cell
        }else if indexPath.section == 2 {
            let cell: NewUserHabitTimeCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.NewUserHabitTimeCell, for: indexPath) as! NewUserHabitTimeCell
            cell.timeLabel.text = habit?.date == nil ? Constants.Strings.DefaultHabitTime : habit!.date?.toHourMinute() 
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitles[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            self.pickerViewBottomConstraint.constant = 0.0
        }
        self.newUserHabitMasterView.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)
        self.newUserHabitMasterView.tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
    
    @IBAction func closePickerView(_ sender: Any) {
        let date = self.newUserHabitMasterView.pickerView.date
        habit?.date = date
        self.pickerViewBottomConstraint.constant = -200.0
        self.newUserHabitMasterView.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.newUserHabitMasterView.tableView.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .none)
    }
    
    
}
