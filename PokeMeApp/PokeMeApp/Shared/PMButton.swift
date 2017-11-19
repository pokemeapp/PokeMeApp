//
//  PMButton.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 09. 25..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit

typealias PMButtonCompletionBlock = (_ button: PMButton) -> Void

class PMButton: UIView {
    
    @IBOutlet weak var button: CYTranslatedButton!
    var buttonTapped: PMButtonCompletionBlock?
    var title: String = ""{
        didSet {
            self.button.translationKey = title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.loadXib()
        self.style()
    }
    
    func style(){
        self.addBorder(color: Constants.Colors.Green, width: 1.0)
        self.addShadow(color: Constants.Colors.ShadowGrey, radius: 10, opacity: 0.8, offset: CGSize(width: 1.0, height: 1.0))
        self.layer.masksToBounds = true
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
        self.button.translationKey = title
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PMButton", bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.loadXib()
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        self.buttonTapped?(self)
    }
    
    
}
    
    
    

    
    

