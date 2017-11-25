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
        
    }
    
    func showDropdownMessage(title: String, url: String?){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dropdownMessageView: DropdownMessageView = DropdownMessageView(frame: CGRect(x: 0, y: -90.0, width: appDelegate.window!.frame.size.width, height: 90.0))
        dropdownMessageView.messageLabel.text = title
        dropdownMessageView.onTapCompletitionBlock = self.tapAction
        if url != nil {
            SDWebImageManager.shared().imageDownloader?.downloadImage(with: URL(string: url!), options: .useNSURLCache, progress:nil) {(maybeImage, data, error, finished) in
                if maybeImage != nil || finished == true, error == nil{
                    dropdownMessageView.profileImageView.image = maybeImage!
                }
            }
        }else{
            dropdownMessageView.profileImageView.image = Constants.Images.DefaultProfileImage
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
    
    @objc func hide(_ sender: Any?){
        guard let dropdownMessageView: DropdownMessageView = sender as? DropdownMessageView else {
            return
            
        }
        dropdownMessageView.removeFromSuperview()
    }
    
    func tapAction(dropdownMessageView: DropdownMessageView){
        dropdownMessageView.removeFromSuperview()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.handleNotification(self.dropdownNotification)
    }
    
    func createDropdownNotification(from userInfo: [AnyHashable : Any]) -> DropdownNotification?{
        var message: String?
        if let aps = userInfo["aps"] as? NSDictionary {
            if let _ = aps["alert"] as? NSDictionary {
            } else if let alert = aps["alert"] as? NSString, let imageUrl = aps["profile_image_url"] as? NSString {
                message = String(alert)
                let url = String(imageUrl)
                return DropdownNotification(message: message!, url: url)
            }
        }
        return nil
    }
    
}
