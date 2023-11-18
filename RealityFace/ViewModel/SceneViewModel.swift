//
//  SceneViewModel.swift
//  RealityFace
//
//  Created by Marko on 15.11.23..
//

import Foundation
import ARKit

class SceneViewModel: NSObject, ARSCNViewDelegate {
        
    var anchorNode: SCNNode?
    var addedNode: Content?
    var faceGeometry: ARSCNFaceGeometry?
    
    var scenes: [SceneType] = [.box, .glasses, .head, .mask]
    var contentSelected: SceneType = .mask
    

    func faceAnchor(faceAnchor: ARFaceAnchor) {
        addedNode?.update(withFaceAnchor: faceAnchor)
    }
    
    func setupFaceNodeContent(node: SCNNode) {
        DispatchQueue.main.async {
            self.anchorNode = node

            node.childNodes.forEach { $0.removeFromParentNode() }
            
            let content = self.getContent(type: self.contentSelected)
            
            self.swapFilter(type: .head)
        }
    }
    
    func createFaceGeometry(sceneView: ARSCNView) {
        
        guard let device = sceneView.device else { return }
        
        if let customSceneDevice = ARSCNFaceGeometry(device: device) {
            self.faceGeometry = customSceneDevice
        }
    }
    
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
    
    func swapFilter(type: SceneType) {
        let content = getContent(type: type)
        self.addedNode = content
        if let anchorNode = anchorNode {
            anchorNode.childNodes.forEach { $0.removeFromParentNode() }
            anchorNode.addChildNode(self.addedNode!)
        }
    }
    
    private func getContent(type: SceneType) -> Content {
        guard let faceGeometry = faceGeometry else {
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
