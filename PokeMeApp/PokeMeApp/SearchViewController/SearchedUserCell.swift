//
//  SearchedUserCell.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 14..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PokeMeKit

class SearchedUserCell: UITableViewCell {

    let disposeBag = DisposeBag()
    let viewModel = SearchedUserViewModel()
    
    @IBOutlet weak var addButton: PMButton!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bindComponents()
        self.addButton.title = "SearchedUser.AddButton.Title".localized
    }
    
    func bindComponents(){
        self.viewModel.name.asObservable().bind(to: self.nameLabel.rx.text).addDisposableTo(disposeBag)
    }

    func bind(to user: PMUser){
        self.viewModel.model = user
    }
    
}
