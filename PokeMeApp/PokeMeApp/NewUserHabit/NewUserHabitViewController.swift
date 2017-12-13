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
        self.newUserHabitMasterView.headerView.controller = self
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
        NotificationCenter.default.addObserver(self, selector: #selector(updateDays), name: Constants.Events.UpdateDays, object: nil)
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
    
    @objc func updateDays(notification: Notification){
        guard let days = notification.object as? String else {
            return
        }
        habit?.day = days
    }
    
    @objc func saveButtonTapped(){

        // TODO: assign values to props from inputs
        let cell: NewUserHabitDayCell = self.newUserHabitMasterView.tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as! NewUserHabitDayCell
        habit?.day = getDayFrom(cell)
        if habit?.hour == nil {
            habit?.hour = "12:00:00"
        }
        print(habit!.day!)
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
                self.navigationController?.popViewController(animated: true)
                LocalPushManager.shared.setUpLocalNotification(message: habit!.description!, hm: habit!.hour!)
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
            cell.controller = self
            return cell
        }else if indexPath.section == 1 {
            let cell: NewUserHabitDescriptionsCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.NewUserHabitDescriptionsCell, for: indexPath) as! NewUserHabitDescriptionsCell
            cell.descriptionLabel.text = habit?.description ?? ""
            cell.controller = self
            return cell
        }else if indexPath.section == 2 && indexPath.row == 0 {
            let cell: NewUserHabitDayCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.NewUserHabitDayCell, for: indexPath) as! NewUserHabitDayCell
            cell.days = habit?.day ?? "0000000"
            return cell
        }else if indexPath.section == 2 && indexPath.row == 1{
            let cell: NewUserHabitTimeCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.NewUserHabitTimeCell, for: indexPath) as! NewUserHabitTimeCell
            let hour = habit?.hour ?? "12:00:00"
            let endIndex = hour.index(hour.endIndex, offsetBy: -3)
            let truncated = hour.substring(to: endIndex)
            cell.timeLabel.text = truncated
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
    
    func getDayFrom(_ cell: NewUserHabitDayCell) -> String{
        
        return cell.getBoxes()
    }
    
    @IBAction func closePickerView(_ sender: Any) {
        let date = self.newUserHabitMasterView.pickerView.date
        habit?.hour = date.toHourMinute() + ":00"
        self.pickerViewBottomConstraint.constant = -200.0
        self.newUserHabitMasterView.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.newUserHabitMasterView.tableView.reloadRows(at: [IndexPath(row: 1, section: 2)], with: .none)
    }
    
    
}
