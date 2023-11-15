//
//  Head.swift
//  RealityFace
//
//  Created by Marko on 14.11.23..
//

import Foundation
import ARKit

class Head: SCNReferenceNode, Content {
    
    private var originalMouthScale: Float = 0

       private lazy var mouth = childNode(withName: "mouth", recursively: true)!
       private lazy var leftEyeNode = childNode(withName: "leftEye", recursively: true)!
       private lazy var rightEyeNode = childNode(withName: "rightEye", recursively: true)!
    
    init() {
        guard let url = Bundle.main.url(forResource: "Head", withExtension: "scn", subdirectory: "art.scnassets")
                    else { fatalError("missing expected bundle resource") }
                super.init(url: url)!
                self.load()
        originalMouthScale = mouth.scale.y
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var blendShapes: [ARFaceAnchor.BlendShapeLocation: Any] = [:] {
            didSet {
                guard let eyeBlinkLeft = blendShapes[.eyeBlinkLeft] as? Float,
                    let eyeBlinkRight = blendShapes[.eyeBlinkRight] as? Float,
                    let jawOpen = blendShapes[.jawOpen] as? Float
                    else { return }
                leftEyeNode.scale.y = (1 - eyeBlinkLeft) * 0.1
                rightEyeNode.scale.y = (1 - eyeBlinkRight) * 0.1
                mouth.scale.y = originalMouthScale + jawOpen * originalMouthScale
                
            }
        }
    
    func update(withFaceAnchor: ARFaceAnchor) {
        blendShapes = withFaceAnchor.blendShapes
        print("Updating b")
    }
}
