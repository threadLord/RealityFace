//
//  Box.swift
//  RealityFace
//
//  Created by Marko on 15.11.23..
//

import Foundation
import ARKit

class Box: SCNNode, Content {
    init(width: Float = 0.1, height: Float = 0.1, length: Float = 0.1, chamferRadius: Float = 0.01) {
        super.init()
        self.geometry = SCNBox(width: CGFloat(width), height: CGFloat(height), length: CGFloat(length), chamferRadius: CGFloat(chamferRadius))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(withFaceAnchor: ARFaceAnchor) {
    }
}
