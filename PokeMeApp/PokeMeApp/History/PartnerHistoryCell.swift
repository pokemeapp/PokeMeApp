//
//  PartnerHistoryCell.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 26..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import PokeMeKit

class PartnerHistoryCell: UITableViewCell {

    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var yesButton: CYTranslatedButton!
    @IBOutlet weak var noButton: CYTranslatedButton!
    
    let disposeBag = DisposeBag()
    var viewModel = ParnerHistoryViewModel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.messageContainerView.layer.cornerRadius = self.messageContainerView.frame.height / 2.0
        self.messageContainerView.addBorder(color: .black, width: 1.0)
        self.bindComponents()
    }
    
    func bindComponents(){
        self.viewModel.message.asObservable().bind(to: self.messageLabel.rx.text).addDisposableTo(disposeBag)
    }
    
    func bind(to model: PMPoke){
        yesButton.tag = model.id!
        noButton.tag = model.id!
        if model.response == "yes" {
            yesButton.setTitleColor(Constants.Colors.Green, for: .normal)
            yesButton.isEnabled = false
            noButton.isEnabled = false
        }
        if model.response == "no" {
            noButton.setTitleColor(Constants.Colors.Green, for: .normal)
            yesButton.isEnabled = false
            noButton.isEnabled = false
        }
        self.viewModel.model = model
    }

}
