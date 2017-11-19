//
//  MessagingPopUpViewController.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 19..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MessagingPopUpViewController: UIViewController {
    
    @IBOutlet weak var messagingOptionsCenterYConstrinat: NSLayoutConstraint!
    @IBOutlet var masterView: MessagingPopUpMasterView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messagingOptionsCenterYConstrinat.constant = self.masterView.frame.height / 2.0 + self.masterView.messageOptionsView.frame.height / 2.0
        self.masterView.messageOptionsView.option4Button.buttonTapped = {
            self.animate(to: .custom)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animate(to: .options)
    }
    
    func animate(to view: MessagePopUpAnimateTo){
        switch view {
        case .options:
            self.messagingOptionsCenterYConstrinat.constant = 0.0
            UIView.animate(withDuration: Constants.Times.MessagePopUpAnimation, animations: { [weak self] in
                self!.masterView.messageOptionsView.alpha = 1.0
                self!.masterView.customMessageView.alpha = 0.0
                self?.masterView.layoutSubviews()
                }, completion: nil)
        case .custom:
            self.messagingOptionsCenterYConstrinat.constant = -200.0
            UIView.animate(withDuration: Constants.Times.MessagePopUpAnimation, animations: { [weak self] in
                self!.masterView.messageOptionsView.alpha = 0.0
                self!.masterView.customMessageView.alpha = 1.0
                self?.masterView.layoutSubviews()
                }, completion: nil)
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.animate(to: .options)
    }
    
}
