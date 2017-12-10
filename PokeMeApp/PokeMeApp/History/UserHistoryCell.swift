//
//  UserHistoryCell.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 26..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class UserHistoryCell: UITableViewCell {

    @IBOutlet weak var yesButton: CYTranslatedButton!
    @IBOutlet weak var noButton: CYTranslatedButton!
    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    let disposeBag = DisposeBag()
    var viewModel = UserHistoryViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.messageContainerView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: self.messageContainerView.frame.height / 2.0)
        self.bindComponents()
    }

    func bindComponents(){
        self.viewModel.message.asObservable().bind(to: self.messageLabel.rx.text).addDisposableTo(disposeBag)
    }
    
    func bind(to model: History){
        self.viewModel.model = model
    }
    
}
