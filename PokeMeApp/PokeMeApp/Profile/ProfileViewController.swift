//
//  ProfileViewController.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 04..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class ProfileViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    let disposeBag = DisposeBag()
    
    @IBOutlet var profileMasterView: ProfileMasterView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.modalPresentationStyle = .fullScreen
        self.initGestures()
    }
}

extension ProfileViewController {
    
    func initGestures(){
        self.profileMasterView.profileImageView.rx.tapGesture().when(.recognized).subscribe(onNext:{ [weak self]gesture in
            self!.present(self!.imagePicker, animated: true, completion: nil)
        }).addDisposableTo(disposeBag)
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.profileMasterView.profileImageView.image = image
            self.dismiss(animated: true, completion: nil)
        } else{
            print("Something went wrong")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
