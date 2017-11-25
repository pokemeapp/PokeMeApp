//
//  DropdownNotification.swift
//  weedmagnet-ios
//
//  Created by Zsolt Pete on 2017. 10. 18..
//  Copyright © 2017. CodeYard. All rights reserved.
//

import UIKit

class DropdownNotification: NSObject {

    var message: String
    var profileImageURL: String?
    var notificationType: UserNotificationType?
    var notificationAboutId: String?
    var notificationById: String?
    var notifiedAboutSecondaryId: String?
    
    init(message: String, url: String? = nil, notificationType: UserNotificationType?, notificationAboutId: String? = nil, notificationById: String? = nil, notifiedAboutSecondaryId: String? = nil) {
        self.message = message
        self.profileImageURL = url
        self.notificationType = notificationType
        self.notificationAboutId = notificationAboutId
        self.notificationById = notificationById
        self.notifiedAboutSecondaryId = notifiedAboutSecondaryId
        super.init()
    }
    
}
