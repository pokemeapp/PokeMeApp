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
    
    var mockHabit: MockHabit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.tabBarItem)
        self.hideKeyboardWhenTappedAround()
        self.messagingOptionsCenterYConstrinat.constant = self.masterView.frame.height / 2.0 + self.masterView.messageOptionsView.frame.height / 2.0
        self.setButtonsActions()
        self.masterView.customMessageView.sendButton.buttonTapped = { button in
            guard let habit = self.mockHabit else {
                return
            }
            guard let text = self.masterView.customMessageView.textView.text else {
                return
            }
            if text.count > 0 {
                self.dismiss(animated: true, completion: nil)
                LocalPushManager.shared.sendLocalPush(title: habit.name!, text: text)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
    
    func sendQuickMessage(_ button: PMButton){
        guard let habit = self.mockHabit else {
            return
        }
        let text = button.title
        LocalPushManager.shared.sendLocalPush(title: habit.name!, text: text)
        self.dismiss(animated: true, completion: nil)
    }
    
    func setButtonsActions(){
        self.masterView.messageOptionsView.option4Button.buttonTapped = { button in
            self.animate(to: .custom)
        }
        self.masterView.messageOptionsView.option3Button.buttonTapped = { button in
            self.sendQuickMessage(button)
        }
        self.masterView.messageOptionsView.option2Button.buttonTapped = { button in
            self.sendQuickMessage(button)
        }
        self.masterView.messageOptionsView.option1Button.buttonTapped = { button in
            self.sendQuickMessage(button)
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.animate(to: .options)
    }
    
}
