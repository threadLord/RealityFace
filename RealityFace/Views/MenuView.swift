//
//  MenuView.swift
//  RealityFace
//
//  Created by Marko on 18.11.23..
//

import UIKit

protocol MenuViewDelegate: AnyObject {
    func selected(type: SceneType)
}

class MenuView: UIView {
    
    @IBOutlet var contentView: MenuView!
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    var menuViewViewModel: MenuViewViewModel = MenuViewViewModel()
    weak var delegate: MenuViewDelegate?
    
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
        contentView.bindFrameToSuperviewBounds()
        
        contentCollectionView.delegate = self
        contentCollectionView.dataSource = self
        contentCollectionView.register(UINib(nibName: MenuCell.cellID, bundle: nil), forCellWithReuseIdentifier: MenuCell.cellID)
        
        contentView.blurredView(effectStyle: .dark, cornerRadius: 0.0)
    }
}

extension MenuView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuViewViewModel.scenes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = contentCollectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.cellID, for: indexPath) as? MenuCell else { return UICollectionViewCell()}
        
        let type = menuViewViewModel.scenes[indexPath.row]
        let image = menuViewViewModel.images[type]
        cell.set(imageNamed: image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedType = menuViewViewModel.scenes[indexPath.row]
        delegate?.selected(type: selectedType)
    }
}
