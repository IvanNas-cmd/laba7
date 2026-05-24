import UIKit
import SceneKit

class Game3DViewController: UIViewController {
    private var scnView: SCNView!
    private var torusNode: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup3DSceneEngine()
        setupControlGestures()
    }
    
    private func setup3DSceneEngine() {
        scnView = SCNView(frame: self.view.bounds)
        scnView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scnView.backgroundColor = .black
        scnView.rendersContinuously = true
        self.view.addSubview(scnView)
        
        let scene = SCNScene()
        scnView.scene = scene
        
        let torusGeometry = SCNTorus(ringRadius: 3.0, pipeRadius: 1.0)
        torusGeometry.firstMaterial?.diffuse.contents = UIColor.systemRed
        torusGeometry.firstMaterial?.specular.contents = UIColor.white
        torusGeometry.firstMaterial?.isLitPerPixel = true
        
        torusNode = SCNNode(geometry: torusGeometry)
        scene.rootNode.addChildNode(torusNode)
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(0, 0, 10)
        scene.rootNode.addChildNode(cameraNode)
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(6, 6, 6)
        scene.rootNode.addChildNode(lightNode)
    }
    
    private func setupControlGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handle3DPan(_:)))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handle3DPinch(_:)))
        scnView.addGestureRecognizer(panGesture)
        scnView.addGestureRecognizer(pinchGesture)
    }
    
    @objc func handle3DPan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: scnView)
        let xRotationAngle = Float(translation.y) * (.pi / 180.0)
        let yRotationAngle = Float(translation.x) * (.pi / 180.0)
        
        torusNode.eulerAngles = SCNVector3(
            torusNode.eulerAngles.x + xRotationAngle * 0.2,
            torusNode.eulerAngles.y + yRotationAngle * 0.2,
            0
        )
        sender.setTranslation(.zero, in: scnView)
    }
    
    @objc func handle3DPinch(_ sender: UIPinchGestureRecognizer) {
        let scaleFactor = Float(sender.scale)
        torusNode.scale = SCNVector3(
            torusNode.scale.x * scaleFactor,
            torusNode.scale.y * scaleFactor,
            torusNode.scale.z * scaleFactor
        )
        sender.scale = 1.0
    }
}
