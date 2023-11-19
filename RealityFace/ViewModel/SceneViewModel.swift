//
//  SceneViewModel.swift
//  RealityFace
//
//  Created by Marko on 15.11.23..
//

import Foundation
import ARKit

class SceneViewModel: NSObject  {
        
    var anchorNode: SCNNode?
    var addedNode: Content?
    var faceGeometry: ARSCNFaceGeometry?
    var contentSelected: SceneType = .box
    
    func faceAnchor(faceAnchor: ARFaceAnchor) {
        addedNode?.update(withFaceAnchor: faceAnchor)
    }
    
    func setupFaceNodeContent(node: SCNNode) {
        DispatchQueue.main.async {
            self.anchorNode = node
            node.childNodes.forEach { $0.removeFromParentNode() }
            self.swapFilter(type: self.contentSelected, geometry: self.faceGeometry)
        }
    }
    
    func createFaceGeometry(sceneView: ARSCNView) {
        guard let device = sceneView.device else { return }
        
        if let customSceneDevice = ARSCNFaceGeometry(device: device) {
            self.faceGeometry = customSceneDevice
        }
    }
    
    func swapFilter(type: SceneType, geometry: ARSCNFaceGeometry?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.contentSelected = type
            let content = self.getContent(type: type, geometry: geometry)
            self.addedNode = content
            if let anchorNode = anchorNode {
                anchorNode.childNodes.forEach { $0.removeFromParentNode() }
                anchorNode.addChildNode(self.addedNode!)
            }
        }
    }
    
    private func getContent(type: SceneType, geometry: ARSCNFaceGeometry?) -> Content {
        guard let faceGeometry = geometry else {
            return Box()
        }
    
        switch type {
        case .mask:
            return Mask(geometry: faceGeometry)
        case .head:
            return Head()
        case .glasses:
            return Glasses(geometry: faceGeometry)
        case .box:
            return Box()
        }
    }
}

extension SceneViewModel: ARSessionDelegate, ARSCNViewDelegate {
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchorLocal = anchor as? ARFaceAnchor else { return }
        faceAnchor(faceAnchor: faceAnchorLocal)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        setupFaceNodeContent(node: node)
    }
}
