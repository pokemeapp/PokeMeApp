//
//  UserHabitViewModel.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 04..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import SDWebImage

class UserHabitViewModel: NSObject {

    var model: MockHabit = MockHabit(){
        didSet {
            self.name.value = model.name ?? ""
            self.habitDescription.value = model.habitDescription ?? ""
            self.image.value = Constants.Images.DefaultProfileImage
            SDWebImageManager.shared().imageDownloader?.downloadImage(with: URL(string: model.imageURL!), options: .progressiveDownload, progress:nil) {  [ weak self] (maybeImage, data, error, finished) in
                if maybeImage != nil || finished == true, error == nil{
                    self?.image.value = maybeImage!
                }
            }
        }
    }
    
    var name: Variable<String> = Variable("")
    var habitDescription: Variable<String> = Variable("")
    var image: Variable<UIImage> = Variable(UIImage())
}
