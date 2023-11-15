//
//  Content.swift
//  RealityFace
//
//  Created by Marko on 14.11.23..
//

import Foundation
import ARKit

protocol Content: SCNNode {
    func update(withFaceAnchor: ARFaceAnchor)
}
