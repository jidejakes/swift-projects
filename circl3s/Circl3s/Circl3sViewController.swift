//
//  Circl3sViewController.swift
//  Circl3s
//
//  Created by Cruuuisegod on 2/11/22.
//

import UIKit
import SceneKit

public func generateQRCode(from string: String) -> UIImage? {
    let data = string.data(using: String.Encoding.ascii)

    if let filter = CIFilter(name: "CIQRCodeGenerator") {
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 3, y: 3)

        if let output = filter.outputImage?.transformed(by: transform) {
            return UIImage(ciImage: output)
        }
    }
    return nil
}

extension UIView {
    func translateAll() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0, widthMultiplier:  CGFloat = 0, heightMultiplier: CGFloat = 0, centerXConstant: CGFloat = 0, centerYConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        
        translateAll()
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leadingAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant))
        }
        
        if let right = right {
            anchors.append(trailingAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if let centerX = centerX {
            anchors.append(centerXAnchor.constraint(equalTo: centerX, constant: centerXConstant))
        }
        
        if let centerY = centerY {
            anchors.append(centerYAnchor.constraint(equalTo: centerY, constant: -centerYConstant))
        }
        
        if widthMultiplier > 0 {
            anchors.append(widthAnchor.constraint(equalTo: (superview?.widthAnchor)!, multiplier: widthMultiplier))
        }
        
        if heightMultiplier > 0 {
            anchors.append(heightAnchor.constraint(equalTo: (superview?.heightAnchor)!, multiplier: heightMultiplier))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        return anchors
    }
}

class Circl3sViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    let qrCode: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(qrCode)
        
        _ = qrCode.anchor(centerX: view.centerXAnchor, centerY: view.centerYAnchor, widthConstant: 250, heightConstant: 250)
        
        //Android https://play.google.com/store/apps/details?id=com.nqb8.altarbell
        //iOS https://apps.apple.com/ng/app/altarbell/id1542215706
        
        let code = "https://apps.apple.com/ng/app/altarbell/id1542215706"
        let image = generateQRCode(from: code)
        qrCode.image = image
    }
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
//
//    override var prefersHomeIndicatorAutoHidden: Bool {
//        return true
//    }
//
//    let lightColors: [UIColor] = [.blue, .yellow, .red, .black, .green, .orange, .purple, .brown]
//    let sceneView: SCNView = {
//        let view = SCNView(frame: UIScreen.main.bounds)
//        view.backgroundColor = .white
//        return view
//    }()
//
//    let scene: SCNScene = {
//        let view = SCNScene()
//        view.removeAllParticleSystems()
//        return view
//    }()
//
//    var light: SCNLight = {
//        let view = SCNLight()
//        view.type = SCNLight.LightType.omni
//        return view
//    }()
//
//    var x = Float.random(in: -0.5...0.5)
//    var y = Float.random(in: -0.5...0.5)
//    var z = Float.random(in: -0.5...0.5)
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let ciFilterList = CIFilter.filterNames(inCategories: nil)
//        for ciFilterName in ciFilterList {
//            print(ciFilterName)
//        }
//
//        createSphere()
//        changeColors()
//    }
//
//    func createSphere() {
//        view.addSubview(sceneView)
//        sceneView.scene = scene
//
//        let camera = SCNCamera()
//        let cameraNode = SCNNode()
//        cameraNode.camera = camera
//        cameraNode.castsShadow = true
//        cameraNode.position = SCNVector3(x: -3.5, y: 0.0, z: 3.5)
//
//        let lightNode = SCNNode()
//        lightNode.light = light
//        lightNode.position = SCNVector3(x: -1.5, y: 1.0, z: 1.5)
//
//        let sphereGeometry = SCNSphere(radius: 0.75)
//        sphereGeometry.firstMaterial?.fillMode = .lines
//        let sphereNode = SCNNode(geometry: sphereGeometry)
//
//        let constraint = SCNLookAtConstraint(target: sphereNode)
//        constraint.isGimbalLockEnabled = true
//        cameraNode.constraints = [constraint]
//
//        scene.rootNode.addChildNode(lightNode)
//        scene.rootNode.addChildNode(cameraNode)
//        scene.rootNode.addChildNode(sphereNode)
//
//        let rotation: [SCNAction] = [
//            SCNAction.rotateBy(x: CGFloat(x), y: CGFloat(y), z: CGFloat(z), duration: 0.5)
//        ]
//        let action = SCNAction.sequence(rotation)
//        sphereNode.runAction(SCNAction.repeatForever(action))
//    }
//
//    func changeColors() {
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) { [self] in
//            light.color = lightColors.randomElement()!
//            changeColors()
//        }
//    }
}
