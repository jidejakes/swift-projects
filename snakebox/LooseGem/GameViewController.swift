//  GameViewController.swift
//  LooseGem
//  Created by jidejakes on 03/08/2018.
//  Copyright © 2018 jidejakes. All rights reserved.

import UIKit
import SpriteKit
import GameplayKit
import GameKit

class GameViewController: UIViewController {
    
    
    var scene: GameScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = GKScene(fileNamed: "GameScene") {
            if let sceneNode = scene.rootNode as! GameScene? {
                sceneNode.scaleMode = .aspectFit
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    view.ignoresSiblingOrder = true
                    view.showsFPS = false
                    view.showsNodeCount = false
                }
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .portrait
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
