//
//  UserHabitViewModel.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 04..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import SDWebImage

class UserHabitViewModel: NSObject {

    var model: MockHabit = MockHabit(){
        didSet {
            self.name.value = model.name ?? ""
            self.habitDescription.value = model.habitDescription ?? ""
            if model.type != nil {
                self.setType(model.type)
            }
            
        }
    }
    
    var name: Variable<String> = Variable("")
    var habitDescription: Variable<String> = Variable("")
    var image: Variable<UIImage> = Variable(UIImage())
    
    func setType(_ type: HabitType?){
        guard let type = type else {
            return
        }
        self.image.value = HabitHelper.shared.convertImage(from: type)
    }
}
