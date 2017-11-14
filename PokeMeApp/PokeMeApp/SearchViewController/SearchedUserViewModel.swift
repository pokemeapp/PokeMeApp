//
//  SearchedUserViewModel.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 14..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class SearchedUserViewModel: NSObject {
    
    var model: MockUser = MockUser(){
        didSet {
            self.name.value = model.fullName ?? ""
            SDWebImageManager.shared().imageDownloader?.downloadImage(with: URL(string: model.imageURL!), options: .useNSURLCache, progress:nil) {  [ weak self] (maybeImage, data, error, finished) in
                if maybeImage != nil || finished == true, error == nil{
                    self?.image.value = maybeImage!
                }
            }
        }
    }
    
    var imageURL: Variable<String> = Variable("")
    var name: Variable<String> = Variable("")
    var image: Variable<UIImage> = Variable(UIImage())

}
