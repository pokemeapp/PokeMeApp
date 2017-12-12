//
//  HistorySection.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 26..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import PokeMeKit

struct HistorySection {
    var header: String
    var items: [PMPoke]
}

extension HistorySection : SectionModelType {
    
    var identity: String {
        return header
    }
    
    init(original: HistorySection, items: [PMPoke]) {
        self = original
        self.items = items
    }
}

