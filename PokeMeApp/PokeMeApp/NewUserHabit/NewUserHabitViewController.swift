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
import PokeMeKit

class NewUserHabitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var api: PMAPI!
    @IBOutlet weak var pickerViewBottomConstraint: NSLayoutConstraint!
    let disposeBag = DisposeBag()
    @IBOutlet var newUserHabitMasterView: NewUserHabitMasterView!
    var habit: PMHabit?
    var isEdit = false
    var headerTitles: [String] = ["UserHabitSectionName".localized, "UserHabitSectionDescription".localized, "UserHabitSectionDate".localized]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newUserHabitMasterView.tableView.dataSource = self
        self.newUserHabitMasterView.tableView.delegate = self
        self.hideKeyboardWhenTappedAround()
        if habit != nil {
            self.isEdit = true
            self.newUserHabitMasterView.headerView.bindComponents(habit!)
        }else{
            habit = PMHabit()
        }
        self.title = "UserHabit.Title".localized
        self.initBarButtons()
    }

    func initBarButtons(){
        let rightButtonItem = UIBarButtonItem.init(
            title: "UserHabit.SaveButton.Title".localized,
            style: .done,
            target: self,
            action: #selector(saveButtonTapped)
        )
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    @objc func saveButtonTapped(){

        // TODO: assign values to props from inputs

        habit?.name = "a"
        habit?.hour = "12:00"
        habit?.day = "1000000"
        habit?.type = "warning"
        habit?.description = "b"

        guard let habit = self.habit else {
            return
        }

        startActivityIndicator()

        if isEdit {
            api.put("api/habits", entity: habit) {(error, habit: PMHabit?) in

                self.stopActivityIndicator()

                guard error == nil else {
                    self.displayAlert(title: "Error saving habit!", message: error!.localizedDescription)
                    return
                }

            }
        } else {
            api.post("api/habits", entity: habit) {(error, habit: PMHabit?) in

                self.stopActivityIndicator()

                guard error == nil else {
                    self.displayAlert(title: "Error saving habit!", message: error!.localizedDescription)
                    return
                }

            }
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: NewUserHabitNameCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.NewUserHabitNameCell, for: indexPath) as! NewUserHabitNameCell
            cell.nameLabel.text = habit?.name ?? ""
            return cell
        }else if indexPath.section == 1 {
            let cell: NewUserHabitDescriptionsCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.NewUserHabitDescriptionsCell, for: indexPath) as! NewUserHabitDescriptionsCell
            cell.descriptionLabel.text = habit?.description ?? ""
            return cell
        }else if indexPath.section == 2 && indexPath.row == 0 {
            let cell: NewUserHabitDayCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.NewUserHabitDayCell, for: indexPath) as! NewUserHabitDayCell
            
            return cell
        }else if indexPath.section == 2 && indexPath.row == 1{
            let cell: NewUserHabitTimeCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.NewUserHabitTimeCell, for: indexPath) as! NewUserHabitTimeCell
            cell.timeLabel.text = habit?.hour == nil ? Constants.Strings.DefaultHabitTime : habit!.hour
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitles[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 && indexPath.row == 1{
            self.pickerViewBottomConstraint.constant = 0.0
        }
        if indexPath != IndexPath(row: 0, section: 2){
            self.newUserHabitMasterView.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)
            self.newUserHabitMasterView.tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        }
    }
    
    @IBAction func closePickerView(_ sender: Any) {
        let date = self.newUserHabitMasterView.pickerView.date
        habit?.hour = date.toHourMinute()
        self.pickerViewBottomConstraint.constant = -200.0
        self.newUserHabitMasterView.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.newUserHabitMasterView.tableView.reloadRows(at: [IndexPath(row: 1, section: 2)], with: .none)
    }
    
    
}
