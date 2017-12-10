//
//  FriendRequestViewModel.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 12. 09..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import Foundation
import RxSwift
import PokeMeKit

class FriendRequestViewModel: NSObject {

    var model: PMFriendRequest? {
        didSet {
            guard let model = model else {
                return
            }

            self.name.value = "\(model.owner!.firstname) \(model.owner!.lastname)"
        }
    }

    var name = Variable("")

}
