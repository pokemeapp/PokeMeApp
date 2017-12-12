//
//  DropdownMessageManager.swift
//  weedmagnet-ios
//
//  Created by Zsolt Pete on 2017. 10. 16..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class DropdownMessageManager: NSObject{
    
    static let shared = DropdownMessageManager()
    var dropdownNotification: DropdownNotification?
    
    func manageDropdown(dropdownNotification: DropdownNotification){
        self.dropdownNotification = dropdownNotification
        showDropdownMessage(title: dropdownNotification.message)
    }
    
    func showDropdownMessage(title: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dropdownMessageView: DropdownMessageView = DropdownMessageView(frame: CGRect(x: 0, y: -90.0, width: appDelegate.window!.frame.size.width, height: 90.0))
        dropdownMessageView.messageLabel.text = title
        dropdownMessageView.onTapCompletitionBlock = self.tapAction
        dropdownMessageView.alpha = 1.0
        appDelegate.window?.addSubview(dropdownMessageView)
        self.showAnimation(dropdownMessageView)
    }
    
    func showAnimation(_ dropdownMessageView: DropdownMessageView){
        UIView.animate(withDuration: 0.4, animations: {
            dropdownMessageView.frame = CGRect(x: 0, y: 0, width: dropdownMessageView.frame.size.width, height: 90.0)
        }) { [weak self](finished) in
            self!.perform(#selector(self!.hide), with: dropdownMessageView, afterDelay: 3.0)
        }
    }
    
    @objc func hide(_ sender: Any?){
        guard let dropdownMessageView: DropdownMessageView = sender as? DropdownMessageView else {
            return
            
        }
        dropdownMessageView.removeFromSuperview()
    }
    
    func tapAction(dropdownMessageView: DropdownMessageView){
        dropdownMessageView.removeFromSuperview()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.handleNotification()
    }
    
    func createDropdownNotification(from userInfo: [AnyHashable : Any]) -> DropdownNotification?{
        var message: String?
        print(userInfo)
        if let aps = userInfo["aps"] as? NSDictionary {
            if let _ = aps["alert"] as? NSDictionary {
            } else if let alert = aps["alert"] as? NSString{
                message = String(alert)
                return DropdownNotification(message: message!)
            }
        }
        
        return nil
    }
    
}
