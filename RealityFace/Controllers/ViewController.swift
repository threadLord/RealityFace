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
    @IBOutlet weak var menuView: MenuView!
    
    
    var viewModel: SceneViewModel = SceneViewModel()
    
    var session: ARSession {
        return sceneView.session
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.createFaceGeometry(sceneView: self.sceneView)
        // Set the view's delegate
        setupScene()
        
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        menuView.delegate = self
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
    
    func setupScene() {
        sceneView.delegate = viewModel
        session.delegate = viewModel
        sceneView.showsStatistics = false
        
        sceneView.automaticallyUpdatesLighting = true /* default setting */
        sceneView.autoenablesDefaultLighting = false /* default setting */
        sceneView.scene.lightingEnvironment.intensity = 1.0 /* default setting */
      
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,
                                  ARSCNDebugOptions.showWorldOrigin,
                                  ARSCNDebugOptions.showPhysicsShapes
//                                        ,
//                                          ARSCNDebugOptions.showBoundingBoxes
        ]
    }
}

extension ViewController: MenuViewDelegate {
    func selected(type: SceneType) {
        guard let device = sceneView.device else { return }
        
        if let customSceneDevice = ARSCNFaceGeometry(device: device) {
            viewModel.swapFilter(type: type, geometry: customSceneDevice)
        }
    }
}
