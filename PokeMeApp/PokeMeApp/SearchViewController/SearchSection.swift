//
//  SearchSection.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 12. 09..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import PokeMeKit

struct SearchSection {
    var header: String
    var items: [Searchable]
}

extension SearchSection : SectionModelType {
    
    var identity: String {
        return header
    }
    
    init(original: SearchSection, items: [Searchable]) {
        self = original
        self.items = items
    }
}

extension PMUser: Searchable {
    
}

extension PMFriendRequest: Searchable {
    
}
