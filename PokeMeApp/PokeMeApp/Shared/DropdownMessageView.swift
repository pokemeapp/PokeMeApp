//
//  DropdownMessageView.swift
//
//
//  Created by Zsolt Pete on 2017. 10. 16..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

typealias DropdownComplatitionBlock = (DropdownMessageView) -> Void

class DropdownMessageView: UIView {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var profileImageView: ProfileImageView!
    
    let disposeBag = DisposeBag()
    var onTapCompletitionBlock: DropdownComplatitionBlock?
    
    var contentView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadXib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.loadXib()
    }
    
    func loadXib() {
        guard contentView == nil else { return }
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
        self.addShadow()
        self.initObservers()
    }
    
    func addShadow(){
        self.layer.shadowColor =  UIColor.black.cgColor
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 1.0, height: 0.0)
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "DropdownMessageView", bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.loadXib()
        contentView?.prepareForInterfaceBuilder()
        self.profileImageView.layer.masksToBounds = true
        self.profileImageView.layer.shadowColor = UIColor.black.cgColor
        self.profileImageView.layer.shadowRadius = 5.0
        self.profileImageView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.profileImageView.layer.shadowOpacity = 0.4
    }
}

extension DropdownMessageView{
    
    func initObservers(){
        self.initTapObserver()
    }
    
    func initTapObserver(){
        self.rx.tapGesture().when(.recognized).subscribe({ [weak self] gesture in
            self!.onTapCompletitionBlock?(self!)
        }).addDisposableTo(disposeBag)
    }
    
}
