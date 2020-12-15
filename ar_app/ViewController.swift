//
//  ViewController.swift
//  ar_app
//
//  Created by 김지현 on 2020/12/16.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var container: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/scene.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        container = scene.rootNode.childNode(withName: "container", recursively: false)!
        
        container.removeFromParentNode()
        
        let particles = container.childNode(withName: "snow", recursively: false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        guard let trackingImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {return}
        
        configuration.trackingImages = trackingImages

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARImageAnchor else {
            return
        }
        container.isHidden = false
        node.addChildNode(container)
        
    }

}
