//
//  MenuView.swift
//  RealityFace
//
//  Created by Marko on 18.11.23..
//

import UIKit

class MenuView: UIView {
    
    @IBOutlet var contentView: MenuView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let view = Bundle.main.loadNibNamed("MenuView", owner: self, options: nil)![0] as! UIView
        addSubview(view)
        view.frame = self.frame
        contentView.frame = self.frame
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .white
        view.backgroundColor = .brown
    }
}
