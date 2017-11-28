//
//  UIViewController+displayMessage.swift
//  PokeMeApp
//
//  Created by Simkó Viktor on 2017. 11. 28..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func displayAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
