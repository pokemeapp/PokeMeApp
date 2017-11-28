//
//  UIViewController+activityIndicator.swift
//  PokeMeApp
//
//  Created by Simkó Viktor on 2017. 11. 28..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit

extension UIViewController {
    
    private func getActivityIndicatorView() -> UIActivityIndicatorView? {
        for case let activityView as UIActivityIndicatorView in self.view.subviews {
            return activityView
        }
        return nil
    }
    
    func startActivityIndicator() {
        guard getActivityIndicatorView() == nil else {
            return
        }
        
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.startAnimating()
        self.view.addSubview(activityView)
        activityView.center = self.view.center
    }
    
    func stopActivityIndicator() {
        guard let activityView = getActivityIndicatorView() else {
            return
        }
        
        activityView.stopAnimating()
        activityView.removeFromSuperview()
    }
    
}
