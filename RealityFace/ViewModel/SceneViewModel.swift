//
//  SceneViewModel.swift
//  RealityFace
//
//  Created by Marko on 15.11.23..
//

import Foundation
import ARKit

enum SceneType {
    case mask
    case head
    case glasses
    case box
}

typealias AllScenes = (SceneType, Content)


class SceneViewModel: NSObject, ARSCNViewDelegate {
        
    var anchorNode: SCNNode?
    var addedNode: Content?
    
    var nodes: [AllScenes] = []
    var contentSelected: SceneType = .mask
    
    

    func faceAnchor(faceAnchor: ARFaceAnchor) {
        addedNode?.update(withFaceAnchor: faceAnchor)
    }
    
    func setupFaceNodeContent(node: SCNNode) {
        
        
        DispatchQueue.main.async {
            self.anchorNode = node

            node.childNodes.forEach { $0.removeFromParentNode() }
            let chooser = self.nodes.first { $0.0 == self.contentSelected  }
            
            if let add = chooser?.1 {
                self.addedNode = add
                node.addChildNode(self.addedNode!)
            }
            
            
            
            
//            switch self.contentTypeSelected {
//            case .none: break
//
//            default:
//                if let content = self.customScene {
//                  node.addChildNode(content)
//                }
//            }
        }
    }
    
    func createFaceGeometry(sceneView: ARSCNView) {
        
        guard let device = sceneView.device else { return }
        
        if let customSceneDevice = ARSCNFaceGeometry(device: device) {
            
            nodes = [
                (SceneType.mask, Mask(geometry: customSceneDevice)),
                (SceneType.head, Head()),
                (SceneType.glasses, Glasses(geometry: customSceneDevice)),
                (SceneType.box, Box())
                
            ]
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
//        updateMessage(text: "Tracking your face.")
        faceAnchor(faceAnchor: faceAnchorLocal)
//        update(withFaceAnchor: anchor as! ARFaceAnchor)
//        anchorNode?.name = FACE_NODE
        print("LIKE")
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        setupFaceNodeContent(node: node)
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
        //            self.testAdding()
        //        }
    }
    
}
