//
//  NewHabitHeaderView.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 13..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum HabitType{
    case health
    case today
    case notification
    case warning
}

class NewHabitHeaderView: UIView {

    var habit = Variable(MockHabit())
    let disposeBag = DisposeBag()
    @IBOutlet var imageView: ProfileImageView!
    @IBOutlet var healthButton: UIButton!
    @IBOutlet var todayButton: UIButton!
    @IBOutlet var notificationButton: UIButton!
    @IBOutlet var warningButton: UIButton!
    var selectedType: HabitType?
    var lastButton: UIButton?
    var buttons: [UIButton] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.buttons = [healthButton, todayButton, notificationButton, warningButton]
    }
    
    func bindComponents(_ habit: MockHabit){
        self.habit.value = habit
        self.habit.asObservable().map { (mockHabit) -> UIImage in
            HabitHelper.shared.convertImage(from: mockHabit.type!)
            }.bind(to: self.imageView.rx.image).addDisposableTo(disposeBag)
        self.lastButton = buttons.filter { (button) -> Bool in
            guard let image = button.imageView?.image else {
                return false
            }
            let type = HabitHelper.shared.convertType(from: image)
            let bool = ( type == (self.habit.value.type)! )
            return bool
        }.first!
        
        self.lastButton?.alpha = 0.0
    }
    
    @IBAction func typeSelected(_ sender: Any) {
        guard let button: UIButton = sender as? UIButton else {
            return
        }
        guard let image = button.imageView?.image else {
            return
        }
        self.selectedType = HabitHelper.shared.convertType(from: image)
        imageView.image = image
        lastButton?.alpha = 1.0
        button.alpha = 0.0
        lastButton = button
    }
    
}
