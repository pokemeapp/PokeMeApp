//
//  ProfileMasterView.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 04..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileMasterView: UIView {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: ProfileImageView!
    
    override func awakeFromNib() {
        let mockUserGenerator = MockUserGenerator(options: [.firstName, .lastName, .fullName, .imageURL])
        let mockUsers = mockUserGenerator.createMockUsers(1)
        let mockUser = mockUsers.first!
        self.nameLabel.text = mockUser.fullName
        SDWebImageManager.shared().imageDownloader?.downloadImage(with: URL(string: mockUser.imageURL!), options: .useNSURLCache, progress:nil) {  [ weak self] (maybeImage, data, error, finished) in
            if maybeImage != nil || finished == true, error == nil{
                self?.profileImageView.image = maybeImage!
            }
        }
    }
}
