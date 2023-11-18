//
//  SceneLoader.swift
//  RealityFace
//
//  Created by Marko on 17.11.23..
//

import SceneKit

class SceneLoader {
    static func loadUsdz(name: String) -> SCNReferenceNode? {
        guard let urlPath = Bundle.main.url(forResource: name, withExtension: "usdz",
                                            subdirectory: "art.scnassets") else { return nil }
        
        let referenceNode = SCNReferenceNode(url: urlPath)
        return referenceNode
    }
    
    static func loadScene(name: String) -> SCNReferenceNode? {
        guard let urlPath = Bundle.main.url(forResource: name, withExtension: "scn",
                                            subdirectory: "art.scnassets") else { return nil }
        
        let referenceNode = SCNReferenceNode(url: urlPath)
        return referenceNode
    }
}
