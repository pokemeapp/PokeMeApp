//
//  FriendHabitCell.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 19..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FriendHabitCell: UITableViewCell {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var friendHabitCellView: FriendHabitCellView!
    var viewModel: FriendHabitViewModel = FriendHabitViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bindComponents()
    }
    
    func bindComponents(){
        self.viewModel.name.asObservable().bind(to: self.friendHabitCellView.nameLabel.rx.text).disposed(by: disposeBag)
        self.viewModel.habitDescription.asObservable().bind(to: self.friendHabitCellView.descriptionLabel.rx.text).disposed(by: disposeBag)
        self.viewModel.image.asObservable().bind(to: self.friendHabitCellView.profileImageView.rx.image).disposed(by: disposeBag)
    }
    
    func bind(to model: MockHabit){
        self.viewModel.model = model
        bindComponents()
    }

}
