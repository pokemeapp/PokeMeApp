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
    
    @IBOutlet weak var messageOptionsView: MessageOptionsView!
    @IBOutlet weak var customMessageView: CustomMessageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customMessageView.alpha = 0.0
        self.initTapGesture()
    }
    
}

extension MessagingPopUpMasterView {
    
    func initTapGesture(){
        self.rx.tapGesture().when(.recognized).subscribe(onNext: { gesture in
            self.parentViewController?.dismiss(animated: true, completion: nil)
        }).addDisposableTo(disposeBag)
    }
    
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
