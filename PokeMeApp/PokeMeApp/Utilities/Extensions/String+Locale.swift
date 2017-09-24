//
//  String+Locale.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 09. 24..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import Foundation
import UIKit

extension String {
    public func localizedWithComment(comment:String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    }
    
    public var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    public func localizeWithFormat(args: CVarArg...) -> String {
        return String(format: self.localized, locale: nil, arguments: args)
    }
    
    public func localizeWithFormat(local:NSLocale?, args: CVarArg...) -> String {
        return String(format: self.localized, locale: local as Locale?, arguments: args)
    }
}
