//
//  UIView+Extensions.swift
//  RealityFace
//
//  Created by Marko on 18.11.23..
//

import UIKit

extension UIView {
    func bindFrameToSuperviewBounds(top: CGFloat = 0.0, bottom: CGFloat = 0.0, leading:  CGFloat = 0.0, trailing: CGFloat = 0.0) {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }

        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottom).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: trailing).isActive = true
    }
    
    func blurredView(effectStyle: UIBlurEffect.Style = .systemUltraThinMaterialDark, cornerRadius: CGFloat = 0.0) {
        backgroundColor = .clear
        // 2
        let blurEffect = UIBlurEffect(style: effectStyle)
        // 3
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.clipsToBounds = true
        blurView.cornerRadius(cornerRadius)
        // 4
        blurView.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(blurView, at: 0)
        blurView.bindFrameToSuperviewBounds()
    }
    
    func cornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
}
