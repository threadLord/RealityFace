//
//  ViewController.swift
//  RealityFace
//
//  Created by Marko on 14.11.23..
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    
    var viewModel: SceneViewModel = SceneViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.createFaceGeometry(sceneView: self.sceneView)
        // Set the view's delegate
        sceneView.delegate = viewModel
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        
        
        // Set the scene to the view
//        sceneView.scene = viewModel.scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARFaceTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
        
  
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
     Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    

}