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
import PokeMeKit

class FriendCell: UITableViewCell {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var friendCellView: FriendHabitCellView!
    var viewModel: FriendViewModel = FriendViewModel()
    var buttonTapped: PMButtonCompletionBlock?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bindComponents()
    }
    
    func bindComponents(){
        self.viewModel.name.asObservable().bind(to: self.friendCellView.nameLabel.rx.text).disposed(by: disposeBag)
//        self.viewModel.image.asObservable().bind(to: self.friendCellView.profileImageView.rx.image).disposed(by: disposeBag)
        self.friendCellView.sendButton.buttonTapped = self.buttonTapped
    }
    
    func bind(to model: PMUser){
        self.viewModel.model = model
        bindComponents()
    }

}
