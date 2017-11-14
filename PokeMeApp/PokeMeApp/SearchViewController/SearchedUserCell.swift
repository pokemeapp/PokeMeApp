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

class SearchedUserCell: UITableViewCell {

    let disposeBag = DisposeBag()
    let viewModel = SearchedUserViewModel()
    
    @IBOutlet weak var addButton: PMButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: ProfileImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bindComponents()
    }
    
    func bindComponents(){
        self.viewModel.image.asObservable().bind(to: self.profileImageView.rx.image).addDisposableTo(disposeBag)
        self.viewModel.name.asObservable().bind(to: self.nameLabel.rx.text).addDisposableTo(disposeBag)
    }

    func bind(to user: MockUser){
        self.viewModel.model = user
    }
    
}
