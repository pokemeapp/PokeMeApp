//
//  EmptyDataSet.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 25..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit

class EmptyDataSet: UIView {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.loadXib()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = 3.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadXib()
    }
    
    func loadXib() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "EmptyDataSet", bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.loadXib()
    }
    
}
