//
//  UserHabitCell.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 04..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import PokeMeKit

class UserHabitCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var userHabitCellView: UserHabitCellView!
    var viewModel: UserHabitViewModel = UserHabitViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bindComponents()
    }
    
    func bindComponents(){
        self.viewModel.name.asObservable().bind(to: self.userHabitCellView.habitNameLabel.rx.text).disposed(by: disposeBag)
        self.viewModel.image.asObservable().bind(to: self.userHabitCellView.imageView.rx.image).disposed(by: disposeBag)
    }
    
    func bind(to model: PMHabit){
        self.viewModel.model = model
        bindComponents()
    }

}
