//
//  PokeHistoryCell.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 12. 10..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PokeMeKit

class PokeHistoryCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    let disposeBag = DisposeBag()
    var viewModel = PokeHistoryViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bindComponents()
    }
    
    func bindComponents(){
        self.viewModel.name.asObservable().bind(to: self.nameLabel.rx.text).addDisposableTo(disposeBag)
    }
    
    func bind(to model: PMPokePrototype){
        self.viewModel.model = model
    }

}
