//
//  Glasses.swift
//  RealityFace
//
//  Created by Marko on 14.11.23..
//

import Foundation
import ARKit

class Glasses: SCNNode, Content {
    
    let occlusionNode: SCNNode
    
    init(geometry: ARSCNFaceGeometry) {
        geometry.firstMaterial!.colorBufferWriteMask = []
        occlusionNode = SCNNode(geometry: geometry)
        occlusionNode.renderingOrder = -1

        super.init()

        addChildNode(occlusionNode)
        
        guard let faceOverlayContent = SceneLoader.loadUsdz(name: "oculos") else {
            return
        }
        
        faceOverlayContent.load()
        faceOverlayContent.simdScale = simd_float3(x: 0.1, y: 0.1, z: 0.1)
        faceOverlayContent.position.y += 0.025
        faceOverlayContent.position.z += 0.01
        
        addChildNode(faceOverlayContent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
        
    func update(withFaceAnchor anchor: ARFaceAnchor) {
        let faceGeometry = occlusionNode.geometry as! ARSCNFaceGeometry
        faceGeometry.update(from: anchor.geometry)
    }
}
