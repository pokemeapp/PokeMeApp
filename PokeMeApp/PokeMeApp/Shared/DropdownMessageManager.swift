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
        self.showDropdownMessage(title: dropdownNotification.message, url: dropdownNotification.profileImageURL)
        NotificationCenter.default.post(name: Constants.Events.UpdateNotificationIndicatorState, object: true)
        if(dropdownNotification.notificationType == .message){
            RestClient.getConversationList { [weak self] (error: String?, list: [Conversation]?) in
                if list != nil {
                    let unreadCount = list!.filter { $0.hasUnreadMessage }.count
                    NotificationCenter.default.post(name: Constants.Events.UpdateMessageIndicatorState, object: ["hasUnreadMessage": true,"badgeText":"\(unreadCount)"])
                }
            }
            
        }
        
    }
    
    func showDropdownMessage(title: String, url: String?){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dropdownMessageView: DropdownMessageView = DropdownMessageView(frame: CGRect(x: 0, y: -90.0, width: appDelegate.window!.frame.size.width, height: 90.0))
        dropdownMessageView.messageLabel.text = title
        dropdownMessageView.onTapCompletitionBlock = self.tapAction
        if url != nil {
            SDWebImageManager.shared().downloadImage(with: URL(string: url!), options: .progressiveDownload, progress:nil) { (maybeImage, maybeError, cacheType, finished: Bool, imageURL) in
                if maybeImage != nil && finished == true {
                    dropdownMessageView.profileImageView.imageView.image = maybeImage!
                }
            }
        }else{
            dropdownMessageView.profileImageView.imageView.image = UIImage(named: "TEMP_feed_profilepicture_placeholder")
        }
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
    
    func hide(_ sender: Any?){
        guard let dropdownMessageView: DropdownMessageView = sender as? DropdownMessageView else {
            return
            
        }
        dropdownMessageView.removeFromSuperview()
    }
    
    func tapAction(dropdownMessageView: DropdownMessageView){
        dropdownMessageView.removeFromSuperview()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.handleNotification(by: self.dropdownNotification)
    }
    
    func createDropdownNotification(from userInfo: [AnyHashable : Any]) -> DropdownNotification?{
        var message: String?
        if let aps = userInfo["aps"] as? NSDictionary {
            if let alert = aps["alert"] as? NSDictionary {
            } else if let alert = aps["alert"] as? NSString {
                message = String(alert)
            }
        }
        if let data = userInfo["data"] as? NSDictionary {
            let imageUrl = data["profile_image_url"] as? String
            let profileImageUrl: String? = imageUrl
            let tmp: Int = data["notification_type"] as! Int
            let notificationType: UserNotificationType = UserNotificationType(rawValue: tmp)!
            let notifiedAboutSecondaryId = data["notified_about_secondary_id"] as? String
            let notifiedAboutId = data["notified_about_id"] as? String
            let notifiedById = data["notified_by_id"] as? String
            guard let message: String = message else {
                return nil
            }
            return DropdownNotification(message: message, url: profileImageUrl, notificationType: notificationType, notificationAboutId: notifiedAboutId, notificationById: notifiedById, notifiedAboutSecondaryId: notifiedAboutSecondaryId)
        }
        return nil
    }
    
}
