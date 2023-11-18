//
//  Mask.swift
//  RealityFace
//
//  Created by Marko on 14.11.23..
//

import Foundation
import ARKit

class Mask: SCNNode, Content {
    init(geometry: ARSCNFaceGeometry) {
        super.init()
        self.geometry = geometry
        
        let material = geometry.firstMaterial!
        
        material.lightingModel = .physicallyBased
        material.diffuse.contents = UIColor.red
        material.roughness.contents = UIColor.black
        
        geometry.firstMaterial?.diffuse.contents = UIColor(hue: 0.0, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        geometry.firstMaterial?.roughness.contents = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
        
    func update(withFaceAnchor anchor: ARFaceAnchor) {
        let faceGeometry = geometry as! ARSCNFaceGeometry
        faceGeometry.update(from: anchor.geometry)
    }
}


extension UIColor {
    func imageWithColor(width: Int, height: Int) -> UIImage {
        let size = CGSize(width: width, height: height)
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
