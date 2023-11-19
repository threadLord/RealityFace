//
//  MenuCell.swift
//  RealityFace
//
//  Created by Marko on 18.11.23..
//

import UIKit

class MenuCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    class var cellID: String {
        return "MenuCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(imageNamed: String?) {
        if let imageNamed = imageNamed {
            let image = UIImage(named: imageNamed)
            imageView.image = image
        }
    }
}
