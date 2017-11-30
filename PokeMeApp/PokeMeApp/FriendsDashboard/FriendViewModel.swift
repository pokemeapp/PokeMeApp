//
//  FriendHabitViewModel.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 19..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import SDWebImage
import PokeMeKit

class FriendViewModel: NSObject {

    var model: PMUser! {
        didSet {
            self.name.value = "\(model.firstname) \(model.lastname)"
//            SDWebImageManager.shared().imageDownloader?.downloadImage(with: URL(string: model.imageURL!), options: .useNSURLCache, progress:nil) {  [ weak self] (maybeImage, data, error, finished) in
//                if maybeImage != nil || finished == true, error == nil{
//                    self?.image.value = maybeImage!
//                }
//            }
            
        }
    }
    
    var name: Variable<String> = Variable("")
//    var image: Variable<UIImage> = Variable(UIImage())
    
}
