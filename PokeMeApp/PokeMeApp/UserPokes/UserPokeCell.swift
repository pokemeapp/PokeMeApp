//
//  UserPokeCell.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 26..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PokeMeKit

class UserPokeCell: UITableViewCell {

    @IBOutlet weak var pokeLabel: UILabel!
    
    let disposeBag = DisposeBag()
    var viewModel = UserPokeViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bindComponents()
    }
    
    func bindComponents(){
        self.viewModel.name.asObservable().bind(to: self.pokeLabel.rx.text).addDisposableTo(disposeBag)
    }
    
    func bind(to model: PMPokePrototype){
        self.viewModel.model = model
    }

}
