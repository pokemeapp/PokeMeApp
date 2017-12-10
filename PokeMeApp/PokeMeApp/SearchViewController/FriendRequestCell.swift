//
//  FriendRequestCell.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 12. 09..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PokeMeKit

class FriendRequestCell: UITableViewCell {

    let disposeBag = DisposeBag()
    let viewModel = FriendRequestViewModel()
    
    @IBOutlet weak var declineButton: PMButton!
    @IBOutlet weak var acceptButton: PMButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bindComponents()
        self.acceptButton.title = "SearchedUser.AcceptButton.Title".localized
        self.declineButton.title = "SearchedUser.DeclineButton.Title".localized
        self.acceptButton.buttonTapped = { button in
            
        }
        
        self.declineButton.buttonTapped = { button in
            
        }
    }
    
    func bindComponents(){
        
        self.viewModel.name.asObservable().bind(to: self.nameLabel.rx.text).addDisposableTo(disposeBag)
    }
    
    func bind(to friendRequest: PMFriendRequest){
        self.viewModel.model = friendRequest
    }

}
