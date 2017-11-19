//
//  MessagingPopUpMasterView.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 19..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxGesture

enum MessagePopUpAnimateTo {
    case options
    case custom
}

class MessagingPopUpMasterView: UIView {
    
    let disposeBag = DisposeBag()
    var isTextViewEditing = false
    
    @IBOutlet weak var messageOptionsView: MessageOptionsView!
    @IBOutlet weak var customMessageView: CustomMessageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customMessageView.alpha = 0.0
        self.initTapGesture()
        self.customMessageView.textView.delegate = self
    }
    
}

extension MessagingPopUpMasterView {
    
    func initTapGesture(){
        self.rx.tapGesture().when(.ended).subscribe(onNext: { [weak self]gesture in
            self?.perform(#selector(self!.hideIfNeeded), with: nil, afterDelay: 0.2)
        }).addDisposableTo(disposeBag)
    }
    
    @objc func hideIfNeeded(){
        if  self.isTextViewEditing {
            
        }else{
            self.parentViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension MessagingPopUpMasterView : UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.isTextViewEditing = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.isTextViewEditing = false
    }
    
}
