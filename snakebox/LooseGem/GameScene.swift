//  GameScene.swift
//  LooseGem
//  Created by jidejakes on 03/08/2018.
//  Copyright © 2018 jidejakes. All rights reserved.

import SpriteKit
import GameplayKit
import GameKit

class GameScene: SKScene, GKGameCenterControllerDelegate {
	
	var score = Int()
	var topLogo: SKLabelNode!
	var topLogo1: SKLabelNode!
	var topLogo2: SKLabelNode!
	var topLogo3: SKLabelNode!
	var topLogo4: SKLabelNode!
	var topLogo5: SKLabelNode!
	var topLogo6: SKLabelNode!
	var topLogo7: SKLabelNode!
	var vsCPU: SKShapeNode!
	var cpuLabel: SKLabelNode!
	var rateLabel: SKLabelNode!
	var rate: SKShapeNode!
	var shareLabel: SKLabelNode!
	var share: SKShapeNode!
	var brown: SKShapeNode!
	var blue: SKShapeNode!
	var cyan: SKShapeNode!
	var magenta: SKShapeNode!
	var purple: SKShapeNode!
	var white: SKShapeNode!
	var yellow: SKShapeNode!
	var brownLabel: SKLabelNode!
	var blueLabel: SKLabelNode!
	var cyanLabel: SKLabelNode!
	var magentaLabel: SKLabelNode!
	var purpleLabel: SKLabelNode!
	var whiteLabel: SKLabelNode!
	var yellowLabel: SKLabelNode!
	var menuLabel: SKLabelNode!
	var menu: SKShapeNode!
	var menu1Label: SKLabelNode!
	var menu1: SKShapeNode!
	var playerPositions: [(Int, Int)] = []
	var backGround: SKShapeNode!
	var gameArray: [(node: SKShapeNode, x: Int, y: Int)] = []
	var scores: SKLabelNode!
	var bestScores: SKLabelNode!
	var bgColor: SKLabelNode!
	var instructionColor: SKLabelNode!
	var instructionColor1: SKLabelNode!
	var instructionColor2: SKLabelNode!
	var instructionColor3: SKLabelNode!
	var instructionColor4: SKLabelNode!
	var instructionColor5: SKLabelNode!
	var instructionColor6: SKLabelNode!
	var instructionColor0: SKLabelNode!
	var instructionColor01: SKLabelNode!
	var instructionColor02: SKLabelNode!
	var instructionColor03: SKLabelNode!
	var headLine: SKLabelNode!
	var headLines: SKShapeNode!
	var leaderboard: SKLabelNode!
	var leaderboards: SKShapeNode!
	var instruction: SKLabelNode!
	var instructions: SKShapeNode!
	
	var game: GameManager!
	
	var scoreP1: CGPoint?
	var scoreP2: CGPoint?
	var scoreP3: CGPoint?
	var scoreP4: CGPoint?
	var scoreP5: CGPoint?
	var scoreP6: CGPoint?
	var scoreP7: CGPoint?
	var scoreP8: CGPoint?
	var scoreP9: CGPoint?
	var scoreP0: CGPoint?
	var scoreP01: CGPoint?
	var scoreP02: CGPoint?
	var scoreP03: CGPoint?
	var scoreP04: CGPoint?
	var scoreP05: CGPoint?
	var scoreP06: CGPoint?
	var scoreP07: CGPoint?
	var scoreP08: CGPoint?
	var scoreP09: CGPoint?
	var scoreP00: CGPoint?
	var scoreP001: CGPoint?
	var scoreP002: CGPoint?
	var scoreP003: CGPoint?
	
	override func didMove(to view: SKView) {
		
		iMenu()
		authPlayer()
		AddScore()
		
		game = GameManager(scene: self)
		
		let moveRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(moveR))
		moveRight.direction = .right
		view.addGestureRecognizer(moveRight)
		let moveLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(moveL))
		moveLeft.direction = .left
		view.addGestureRecognizer(moveLeft)
		let moveUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(moveU))
		moveUp.direction = .up
		view.addGestureRecognizer(moveUp)
		let moveDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(moveD))
		moveDown.direction = .down
		view.addGestureRecognizer(moveDown)
	}
	
	@objc func moveR() {
		game.moves(ID: 3)
	}
	@objc func moveL() {
		game.moves(ID: 1)
	}
	@objc func moveU() {
		game.moves(ID: 2)
	}
	@objc func moveD() {
		game.moves(ID: 4)
	}
	
	override func update(_ currentTime: TimeInterval ) {
		game.update(time: currentTime)
	}
	
	private func AddScore() {
		
		score = (UserDefaults.standard.integer(forKey: "bestScores"))
		
	}
	
	private func CallGC() {
		
		saveHS(number: score)
		showLeaderboard()
	}
	
	func authPlayer(){
		
		let localPlayer = GKLocalPlayer.localPlayer()
		localPlayer.authenticateHandler = {
			
			(view, error) in
			
			if view != nil {
				
				self.view?.window?.rootViewController?.present(view!, animated: true, completion: nil)
			} else {
				print(GKLocalPlayer.localPlayer().isAuthenticated)
			}
		}
	}
	
	func saveHS(number: Int) {
		
		if GKLocalPlayer.localPlayer().isAuthenticated {
			
			let scoreReport = GKScore(leaderboardIdentifier: "loosegem")
			
			scoreReport.value = Int64(number)
			
			let scoreArray : [GKScore] = [scoreReport]
			
			GKScore.report(scoreArray, withCompletionHandler: nil)
		}
	}
	
	func showLeaderboard() {
		let vc = self.view?.window?.rootViewController
		let gcVc = GKGameCenterViewController()
		gcVc.gameCenterDelegate = self
		
		vc?.present(gcVc, animated: true, completion: nil)
	}
	
	func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
		gameCenterViewController.dismiss(animated: true, completion: nil)
	}
	
	private func createBoard(width: Int, height: Int) {
		let cWidth: CGFloat = 25
		let nRows = 50
		let nCols = 29
		var x = CGFloat(width / -2) + (cWidth / 2)
		var y = CGFloat(height / 2) - (cWidth / 2)
		for i in 0...nRows - 1 {
			for j in 0...nCols - 1 {
				let cNode = SKShapeNode(rectOf: CGSize(width: cWidth, height: cWidth))
				cNode.strokeColor = SKColor.clear
				cNode.zPosition = 0
				cNode.position = CGPoint(x: x, y: y)
				gameArray.append((node: cNode, x: i, y: j))
				backGround.addChild(cNode)
				x += cWidth
			}
			x = CGFloat(width / -2) + (cWidth / 2)
			y -= cWidth
		}
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			let location = touch.location(in: self)
			let tNode = self.nodes(at: location)
			for node in tNode {
				if node.name == "vsCPU" {
					AddScore()
					colorMenu()
					self.bestScores.isHidden = true
					self.headLine.isHidden = true
					self.headLines.isHidden = true
					self.leaderboard.isHidden = true
					self.leaderboards.isHidden = true
                    self.instruction.isHidden = true
                    self.instructions.isHidden = true
				} else if node.name == "brown" {
					AddScore()
					beginGame()
					self.bestScores.isHidden = true
					self.bgColor.isHidden = true
					self.headLine.isHidden = true
					self.headLines.isHidden = true
					self.leaderboard.isHidden = true
					self.leaderboards.isHidden = true
				} else if node.name == "blue" {
					AddScore()
					beginGame1()
					self.bestScores.isHidden = true
					self.bgColor.isHidden = true
					self.headLine.isHidden = true
					self.headLines.isHidden = true
					self.leaderboard.isHidden = true
					self.leaderboards.isHidden = true
				} else if node.name == "cyan" {
					AddScore()
					beginGame2()
					self.bestScores.isHidden = true
					self.bgColor.isHidden = true
					self.headLine.isHidden = true
					self.headLines.isHidden = true
					self.leaderboard.isHidden = true
					self.leaderboards.isHidden = true
				} else if node.name == "magenta" {
					AddScore()
					beginGame3()
					self.bestScores.isHidden = true
					self.bgColor.isHidden = true
					self.headLine.isHidden = true
					self.headLines.isHidden = true
					self.leaderboard.isHidden = true
					self.leaderboards.isHidden = true
				} else if node.name == "purple" {
					AddScore()
					beginGame4()
					self.bestScores.isHidden = true
					self.bgColor.isHidden = true
					self.headLine.isHidden = true
					self.headLines.isHidden = true
					self.leaderboard.isHidden = true
					self.leaderboards.isHidden = true
				} else if node.name == "white" {
					AddScore()
					beginGame5()
					self.bestScores.isHidden = true
					self.bgColor.isHidden = true
					self.headLine.isHidden = true
					self.headLines.isHidden = true
					self.leaderboard.isHidden = true
					self.leaderboards.isHidden = true
				} else if node.name == "yellow" {
					AddScore()
					beginGame6()
					self.bestScores.isHidden = true
					self.bgColor.isHidden = true
					self.headLine.isHidden = true
					self.headLines.isHidden = true
					self.leaderboard.isHidden = true
					self.leaderboards.isHidden = true
				} else if node.name == "rate" {
					AddScore()
					ratePage()
				} else if node.name == "share" {
					AddScore()
					sharePage()
				} else if node.name == "info" {
					AddScore()
					infoPage()
				} else if node.name == "leaderboards" {
					AddScore()
					CallGC()
				} else if node.name == "instructions" {
					AddScore()
					instructionMenu()
					self.bestScores.isHidden = true
					self.headLine.isHidden = true
					self.headLines.isHidden = true
					self.leaderboard.isHidden = true
					self.leaderboards.isHidden = true
				} else if node.name == "menu" {
					AddScore()
					iMenu()
					
					brown.run(SKAction.scale(to: 0, duration: 0)) {
						self.brown.isHidden = true
					}
					
					self.brownLabel.isHidden = true
					
					blue.run(SKAction.scale(to: 0, duration: 0)) {
						self.blue.isHidden = true
					}
					
					self.blueLabel.isHidden = true
					
					cyan.run(SKAction.scale(to: 0, duration: 0)) {
						self.cyan.isHidden = true
					}
					
					self.cyanLabel.isHidden = true
					
					magenta.run(SKAction.scale(to: 0, duration: 0)) {
						self.magenta.isHidden = true
					}
					
					self.magentaLabel.isHidden = true
					
					purple.run(SKAction.scale(to: 0, duration: 0)) {
						self.purple.isHidden = true
					}
					
					self.purpleLabel.isHidden = true
					
					white.run(SKAction.scale(to: 0, duration: 0)) {
						self.white.isHidden = true
					}
					
					self.whiteLabel.isHidden = true
					
					yellow.run(SKAction.scale(to: 0, duration: 0)) {
						self.yellow.isHidden = true
					}
					
					self.yellowLabel.isHidden = true
					
					menu.run(SKAction.scale(to: 0, duration: 0)) {
						self.menu.isHidden = true
					}
					
					self.menuLabel.isHidden = true
					
					self.bgColor.isHidden = true
					
				} else if node.name == "menu1" {
					AddScore()
					iMenu()
					
					menu1.run(SKAction.scale(to: 0, duration: 0)) {
						self.menu1.isHidden = true
					}
					
					self.menu1Label.isHidden = true
					
					self.instructionColor.isHidden = true
					self.instructionColor1.isHidden = true
					self.instructionColor2.isHidden = true
					self.instructionColor3.isHidden = true
					self.instructionColor4.isHidden = true
					self.instructionColor5.isHidden = true
					self.instructionColor6.isHidden = true
					self.instructionColor0.isHidden = true
					self.instructionColor01.isHidden = true
					self.instructionColor02.isHidden = true
					self.instructionColor03.isHidden = true
				}
			}
		}
	}
	
	private func beginGame() {
		
		theGameView()
		
		vsCPU.run(SKAction.scale(to: 0, duration: 0)) {
			self.vsCPU.isHidden = true
		}
		
		self.cpuLabel.isHidden = true
		
		rate.run(SKAction.scale(to: 0, duration: 0)) {
			self.rate.isHidden = true
		}
		
		self.rateLabel.isHidden = true
		
		share.run(SKAction.scale(to: 0, duration: 0)) {
			self.share.isHidden = true
		}
		
		self.shareLabel.isHidden = true
		
		brown.run(SKAction.scale(to: 0, duration: 0)) {
			self.brown.isHidden = true
		}
		
		self.brownLabel.isHidden = true
		
		blue.run(SKAction.scale(to: 0, duration: 0)) {
			self.blue.isHidden = true
		}
		
		self.blueLabel.isHidden = true
		
		cyan.run(SKAction.scale(to: 0, duration: 0)) {
			self.cyan.isHidden = true
		}
		
		self.cyanLabel.isHidden = true
		
		magenta.run(SKAction.scale(to: 0, duration: 0)) {
			self.magenta.isHidden = true
		}
		
		self.magentaLabel.isHidden = true
		
		purple.run(SKAction.scale(to: 0, duration: 0)) {
			self.purple.isHidden = true
		}
		
		self.purpleLabel.isHidden = true
		
		white.run(SKAction.scale(to: 0, duration: 0)) {
			self.white.isHidden = true
		}
		
		self.whiteLabel.isHidden = true
		
		yellow.run(SKAction.scale(to: 0, duration: 0)) {
			self.yellow.isHidden = true
		}
		
		self.yellowLabel.isHidden = true
		
		menu.run(SKAction.scale(to: 0, duration: 0)) {
			self.menu.isHidden = true
		}
		
		self.menuLabel.isHidden = true
		
		self.bestScores.isHidden = true
		self.bgColor.isHidden = true
		self.headLine.isHidden = true
		self.headLines.isHidden = true
		self.leaderboard.isHidden = true
		self.leaderboards.isHidden = true
		
		let over = CGPoint(x: 0, y: (frame.size.height / +2) - 30)
		scores.run(SKAction.move(to: over, duration: 0)) {
			self.backGround.setScale(0)
			self.scores.setScale(0)
			self.backGround.isHidden = false
			self.scores.isHidden = false
			self.backGround.run(SKAction.scale(to: 1, duration: 0))
			self.scores.run(SKAction.scale(to: 1, duration: 0))
			self.game.theGame()
		}
}
	
	private func beginGame1() {
		
		theGameView1()
		
		vsCPU.run(SKAction.scale(to: 0, duration: 0)) {
			self.vsCPU.isHidden = true
		}
		
		self.cpuLabel.isHidden = true
		
		rate.run(SKAction.scale(to: 0, duration: 0)) {
			self.rate.isHidden = true
		}
		
		self.rateLabel.isHidden = true
		
		share.run(SKAction.scale(to: 0, duration: 0)) {
			self.share.isHidden = true
		}
		
		self.shareLabel.isHidden = true
		
		brown.run(SKAction.scale(to: 0, duration: 0)) {
			self.brown.isHidden = true
		}
		
		self.brownLabel.isHidden = true
		
		blue.run(SKAction.scale(to: 0, duration: 0)) {
			self.blue.isHidden = true
		}
		
		self.blueLabel.isHidden = true
		
		cyan.run(SKAction.scale(to: 0, duration: 0)) {
			self.cyan.isHidden = true
		}
		
		self.cyanLabel.isHidden = true
		
		magenta.run(SKAction.scale(to: 0, duration: 0)) {
			self.magenta.isHidden = true
		}
		
		self.magentaLabel.isHidden = true
		
		purple.run(SKAction.scale(to: 0, duration: 0)) {
			self.purple.isHidden = true
		}
		
		self.purpleLabel.isHidden = true
		
		white.run(SKAction.scale(to: 0, duration: 0)) {
			self.white.isHidden = true
		}
		
		self.whiteLabel.isHidden = true
		
		yellow.run(SKAction.scale(to: 0, duration: 0)) {
			self.yellow.isHidden = true
		}
		
		self.yellowLabel.isHidden = true
		
		menu.run(SKAction.scale(to: 0, duration: 0)) {
			self.menu.isHidden = true
		}
		
		self.menuLabel.isHidden = true
		
		self.bestScores.isHidden = true
		self.bgColor.isHidden = true
		self.headLine.isHidden = true
		self.headLines.isHidden = true
		self.leaderboard.isHidden = true
		self.leaderboards.isHidden = true
		
		let over = CGPoint(x: 0, y: (frame.size.height / +2) - 30)
		scores.run(SKAction.move(to: over, duration: 0)) {
			self.backGround.setScale(0)
			self.scores.setScale(0)
			self.backGround.isHidden = false
			self.scores.isHidden = false
			self.backGround.run(SKAction.scale(to: 1, duration: 0))
			self.scores.run(SKAction.scale(to: 1, duration: 0))
			self.game.theGame()
		}
	}
	
	private func beginGame2() {
		
		theGameView2()
		
		vsCPU.run(SKAction.scale(to: 0, duration: 0)) {
			self.vsCPU.isHidden = true
		}
		
		self.cpuLabel.isHidden = true
		
		rate.run(SKAction.scale(to: 0, duration: 0)) {
			self.rate.isHidden = true
		}
		
		self.rateLabel.isHidden = true
		
		share.run(SKAction.scale(to: 0, duration: 0)) {
			self.share.isHidden = true
		}
		
		self.shareLabel.isHidden = true
		
		brown.run(SKAction.scale(to: 0, duration: 0)) {
			self.brown.isHidden = true
		}
		
		self.brownLabel.isHidden = true
		
		blue.run(SKAction.scale(to: 0, duration: 0)) {
			self.blue.isHidden = true
		}
		
		self.blueLabel.isHidden = true
		
		cyan.run(SKAction.scale(to: 0, duration: 0)) {
			self.cyan.isHidden = true
		}
		
		self.cyanLabel.isHidden = true
		
		magenta.run(SKAction.scale(to: 0, duration: 0)) {
			self.magenta.isHidden = true
		}
		
		self.magentaLabel.isHidden = true
		
		purple.run(SKAction.scale(to: 0, duration: 0)) {
			self.purple.isHidden = true
		}
		
		self.purpleLabel.isHidden = true
		
		white.run(SKAction.scale(to: 0, duration: 0)) {
			self.white.isHidden = true
		}
		
		self.whiteLabel.isHidden = true
		
		yellow.run(SKAction.scale(to: 0, duration: 0)) {
			self.yellow.isHidden = true
		}
		
		self.yellowLabel.isHidden = true
		
		menu.run(SKAction.scale(to: 0, duration: 0)) {
			self.menu.isHidden = true
		}
		
		self.menuLabel.isHidden = true
		
		self.bestScores.isHidden = true
		self.bgColor.isHidden = true
		self.headLine.isHidden = true
		self.headLines.isHidden = true
		self.leaderboard.isHidden = true
		self.leaderboards.isHidden = true
		
		let over = CGPoint(x: 0, y: (frame.size.height / +2) - 30)
		scores.run(SKAction.move(to: over, duration: 0)) {
			self.backGround.setScale(0)
			self.scores.setScale(0)
			self.backGround.isHidden = false
			self.scores.isHidden = false
			self.backGround.run(SKAction.scale(to: 1, duration: 0))
			self.scores.run(SKAction.scale(to: 1, duration: 0))
			self.game.theGame()
		}
		
	}
	
	private func beginGame3() {
		
		theGameView3()
		
		vsCPU.run(SKAction.scale(to: 0, duration: 0)) {
			self.vsCPU.isHidden = true
		}
		
		self.cpuLabel.isHidden = true
		
		rate.run(SKAction.scale(to: 0, duration: 0)) {
			self.rate.isHidden = true
		}
		
		self.rateLabel.isHidden = true
		
		share.run(SKAction.scale(to: 0, duration: 0)) {
			self.share.isHidden = true
		}
		
		self.shareLabel.isHidden = true
		
		brown.run(SKAction.scale(to: 0, duration: 0)) {
			self.brown.isHidden = true
		}
		
		self.brownLabel.isHidden = true
		
		blue.run(SKAction.scale(to: 0, duration: 0)) {
			self.blue.isHidden = true
		}
		
		self.blueLabel.isHidden = true
		
		cyan.run(SKAction.scale(to: 0, duration: 0)) {
			self.cyan.isHidden = true
		}
		
		self.cyanLabel.isHidden = true
		
		magenta.run(SKAction.scale(to: 0, duration: 0)) {
			self.magenta.isHidden = true
		}
		
		self.magentaLabel.isHidden = true
		
		purple.run(SKAction.scale(to: 0, duration: 0)) {
			self.purple.isHidden = true
		}
		
		self.purpleLabel.isHidden = true
		
		white.run(SKAction.scale(to: 0, duration: 0)) {
			self.white.isHidden = true
		}
		
		self.whiteLabel.isHidden = true
		
		yellow.run(SKAction.scale(to: 0, duration: 0)) {
			self.yellow.isHidden = true
		}
		
		self.yellowLabel.isHidden = true
		
		menu.run(SKAction.scale(to: 0, duration: 0)) {
			self.menu.isHidden = true
		}
		
		self.menuLabel.isHidden = true
		
		self.bestScores.isHidden = true
		self.bgColor.isHidden = true
		self.headLine.isHidden = true
		self.headLines.isHidden = true
		self.leaderboard.isHidden = true
		self.leaderboards.isHidden = true
		
		let over = CGPoint(x: 0, y: (frame.size.height / +2) - 30)
		scores.run(SKAction.move(to: over, duration: 0)) {
			self.backGround.setScale(0)
			self.scores.setScale(0)
			self.backGround.isHidden = false
			self.scores.isHidden = false
			self.backGround.run(SKAction.scale(to: 1, duration: 0))
			self.scores.run(SKAction.scale(to: 1, duration: 0))
			self.game.theGame()
		}
	}
	
	private func beginGame4() {
		
		theGameView4()
		
		vsCPU.run(SKAction.scale(to: 0, duration: 0)) {
			self.vsCPU.isHidden = true
		}
		
		self.cpuLabel.isHidden = true
		
		rate.run(SKAction.scale(to: 0, duration: 0)) {
			self.rate.isHidden = true
		}
		
		self.rateLabel.isHidden = true
		
		share.run(SKAction.scale(to: 0, duration: 0)) {
			self.share.isHidden = true
		}
		
		self.shareLabel.isHidden = true
		
		brown.run(SKAction.scale(to: 0, duration: 0)) {
			self.brown.isHidden = true
		}
		
		self.brownLabel.isHidden = true
		
		blue.run(SKAction.scale(to: 0, duration: 0)) {
			self.blue.isHidden = true
		}
		
		self.blueLabel.isHidden = true
		
		cyan.run(SKAction.scale(to: 0, duration: 0)) {
			self.cyan.isHidden = true
		}
		
		self.cyanLabel.isHidden = true
		
		magenta.run(SKAction.scale(to: 0, duration: 0)) {
			self.magenta.isHidden = true
		}
		
		self.magentaLabel.isHidden = true
		
		purple.run(SKAction.scale(to: 0, duration: 0)) {
			self.purple.isHidden = true
		}
		
		self.purpleLabel.isHidden = true
		
		white.run(SKAction.scale(to: 0, duration: 0)) {
			self.white.isHidden = true
		}
		
		self.whiteLabel.isHidden = true
		
		yellow.run(SKAction.scale(to: 0, duration: 0)) {
			self.yellow.isHidden = true
		}
		
		self.yellowLabel.isHidden = true
		
		menu.run(SKAction.scale(to: 0, duration: 0)) {
			self.menu.isHidden = true
		}
		
		self.menuLabel.isHidden = true
		
		self.bestScores.isHidden = true
		self.bgColor.isHidden = true
		self.headLine.isHidden = true
		self.headLines.isHidden = true
		self.leaderboard.isHidden = true
		self.leaderboards.isHidden = true
		
		let over = CGPoint(x: 0, y: (frame.size.height / +2) - 30)
		scores.run(SKAction.move(to: over, duration: 0)) {
			self.backGround.setScale(0)
			self.scores.setScale(0)
			self.backGround.isHidden = false
			self.scores.isHidden = false
			self.backGround.run(SKAction.scale(to: 1, duration: 0))
			self.scores.run(SKAction.scale(to: 1, duration: 0))
			self.game.theGame()
		}
	}
	
	private func beginGame5() {
		
		theGameView5()
		
		vsCPU.run(SKAction.scale(to: 0, duration: 0)) {
			self.vsCPU.isHidden = true
		}
		
		self.cpuLabel.isHidden = true
		
		rate.run(SKAction.scale(to: 0, duration: 0)) {
			self.rate.isHidden = true
		}
		
		self.rateLabel.isHidden = true
		
		share.run(SKAction.scale(to: 0, duration: 0)) {
			self.share.isHidden = true
		}
		
		self.shareLabel.isHidden = true
		
		brown.run(SKAction.scale(to: 0, duration: 0)) {
			self.brown.isHidden = true
		}
		
		self.brownLabel.isHidden = true
		
		blue.run(SKAction.scale(to: 0, duration: 0)) {
			self.blue.isHidden = true
		}
		
		self.blueLabel.isHidden = true
		
		cyan.run(SKAction.scale(to: 0, duration: 0)) {
			self.cyan.isHidden = true
		}
		
		self.cyanLabel.isHidden = true
		
		magenta.run(SKAction.scale(to: 0, duration: 0)) {
			self.magenta.isHidden = true
		}
		
		self.magentaLabel.isHidden = true
		
		purple.run(SKAction.scale(to: 0, duration: 0)) {
			self.purple.isHidden = true
		}
		
		self.purpleLabel.isHidden = true
		
		white.run(SKAction.scale(to: 0, duration: 0)) {
			self.white.isHidden = true
		}
		
		self.whiteLabel.isHidden = true
		
		yellow.run(SKAction.scale(to: 0, duration: 0)) {
			self.yellow.isHidden = true
		}
		
		self.yellowLabel.isHidden = true
		
		menu.run(SKAction.scale(to: 0, duration: 0)) {
			self.menu.isHidden = true
		}
		
		self.menuLabel.isHidden = true
		
		self.bestScores.isHidden = true
		self.bgColor.isHidden = true
		self.headLine.isHidden = true
		self.headLines.isHidden = true
		self.leaderboard.isHidden = true
		self.leaderboards.isHidden = true
		
		let over = CGPoint(x: 0, y: (frame.size.height / +2) - 30)
		scores.run(SKAction.move(to: over, duration: 0)) {
			self.backGround.setScale(0)
			self.scores.setScale(0)
			self.backGround.isHidden = false
			self.scores.isHidden = false
			self.backGround.run(SKAction.scale(to: 1, duration: 0))
			self.scores.run(SKAction.scale(to: 1, duration: 0))
			self.game.theGame()
		}
	}
	
	private func beginGame6() {
		
		theGameView6()
		
		vsCPU.run(SKAction.scale(to: 0, duration: 0)) {
			self.vsCPU.isHidden = true
		}
		
		self.cpuLabel.isHidden = true
		
		rate.run(SKAction.scale(to: 0, duration: 0)) {
			self.rate.isHidden = true
		}
		
		self.rateLabel.isHidden = true
		
		share.run(SKAction.scale(to: 0, duration: 0)) {
			self.share.isHidden = true
		}
		
		self.shareLabel.isHidden = true
		
		brown.run(SKAction.scale(to: 0, duration: 0)) {
			self.brown.isHidden = true
		}
		
		self.brownLabel.isHidden = true
		
		blue.run(SKAction.scale(to: 0, duration: 0)) {
			self.blue.isHidden = true
		}
		
		self.blueLabel.isHidden = true
		
		cyan.run(SKAction.scale(to: 0, duration: 0)) {
			self.cyan.isHidden = true
		}
		
		self.cyanLabel.isHidden = true
		
		magenta.run(SKAction.scale(to: 0, duration: 0)) {
			self.magenta.isHidden = true
		}
		
		self.magentaLabel.isHidden = true
		
		purple.run(SKAction.scale(to: 0, duration: 0)) {
			self.purple.isHidden = true
		}
		
		self.purpleLabel.isHidden = true
		
		white.run(SKAction.scale(to: 0, duration: 0)) {
			self.white.isHidden = true
		}
		
		self.whiteLabel.isHidden = true
		
		yellow.run(SKAction.scale(to: 0, duration: 0)) {
			self.yellow.isHidden = true
		}
		
		self.yellowLabel.isHidden = true
		
		menu.run(SKAction.scale(to: 0, duration: 0)) {
			self.menu.isHidden = true
		}
		
		self.menuLabel.isHidden = true
		
		self.bestScores.isHidden = true
		self.bgColor.isHidden = true
		self.headLine.isHidden = true
		self.headLines.isHidden = true
		self.leaderboard.isHidden = true
		self.leaderboards.isHidden = true
		
		let over = CGPoint(x: 0, y: (frame.size.height / +2) - 30)
		scores.run(SKAction.move(to: over, duration: 0)) {
			self.backGround.setScale(0)
			self.scores.setScale(0)
			self.backGround.isHidden = false
			self.scores.isHidden = false
			self.backGround.run(SKAction.scale(to: 1, duration: 0))
			self.scores.run(SKAction.scale(to: 1, duration: 0))
			self.game.theGame()
		}
	}
	
	private func theGameView() {
		
		scores = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		scores.zPosition = 1
		scores.position = CGPoint(x: 0, y: (frame.size.height / +2) - 30)
		scores.fontSize = 30
		scores.isHidden = false
		scores.text = "0"
		scores.fontColor = SKColor.white
		self.scores.run(SKAction.scale(to: 1, duration: 0))
		self.addChild(scores)
		let width = frame.size.width - 25
		let height = frame.size.height - 84
		let rect = CGRect(x: -width / 2, y: -height / 2, width: width, height: height)
		backGround = SKShapeNode(rect: rect, cornerRadius: 0.02)
		backGround.fillColor = SKColor.brown
		backGround.zPosition = 2
		backGround.isHidden = false
		self.addChild(backGround)
		
		createBoard(width: Int(width), height: Int(height))
	}
	
	private func theGameView1() {
		
		scores = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		scores.zPosition = 1
		scores.position = CGPoint(x: 0, y: (frame.size.height / +2) - 30)
		scores.fontSize = 30
		scores.isHidden = false
		scores.text = "0"
		scores.fontColor = SKColor.white
		self.scores.run(SKAction.scale(to: 1, duration: 0))
		self.addChild(scores)
		let width = frame.size.width - 25
		let height = frame.size.height - 84
		let rect = CGRect(x: -width / 2, y: -height / 2, width: width, height: height)
		backGround = SKShapeNode(rect: rect, cornerRadius: 0.02)
		backGround.fillColor = SKColor.blue
		backGround.zPosition = 2
		backGround.isHidden = false
		self.addChild(backGround)
		
		createBoard(width: Int(width), height: Int(height))
	}
	
	private func theGameView2() {
		
		scores = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		scores.zPosition = 1
		scores.position = CGPoint(x: 0, y: (frame.size.height / +2) - 30)
		scores.fontSize = 30
		scores.isHidden = false
		scores.text = "0"
		scores.fontColor = SKColor.white
		self.scores.run(SKAction.scale(to: 1, duration: 0))
		self.addChild(scores)
		let width = frame.size.width - 25
		let height = frame.size.height - 84
		let rect = CGRect(x: -width / 2, y: -height / 2, width: width, height: height)
		backGround = SKShapeNode(rect: rect, cornerRadius: 0.02)
		backGround.fillColor = SKColor.cyan
		backGround.zPosition = 2
		backGround.isHidden = false
		self.addChild(backGround)
		
		createBoard(width: Int(width), height: Int(height))
	}
	
	private func theGameView3() {
		
		scores = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		scores.zPosition = 1
		scores.position = CGPoint(x: 0, y: (frame.size.height / +2) - 30)
		scores.fontSize = 30
		scores.isHidden = false
		scores.text = "0"
		scores.fontColor = SKColor.white
		self.scores.run(SKAction.scale(to: 1, duration: 0))
		self.addChild(scores)
		let width = frame.size.width - 25
		let height = frame.size.height - 84
		let rect = CGRect(x: -width / 2, y: -height / 2, width: width, height: height)
		backGround = SKShapeNode(rect: rect, cornerRadius: 0.02)
		backGround.fillColor = SKColor.magenta
		backGround.zPosition = 2
		backGround.isHidden = false
		self.addChild(backGround)
		
		createBoard(width: Int(width), height: Int(height))
	}
	
	private func theGameView4() {
		
		scores = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		scores.zPosition = 1
		scores.position = CGPoint(x: 0, y: (frame.size.height / +2) - 30)
		scores.fontSize = 30
		scores.isHidden = false
		scores.text = "0"
		scores.fontColor = SKColor.white
		self.scores.run(SKAction.scale(to: 1, duration: 0))
		self.addChild(scores)
		let width = frame.size.width - 25
		let height = frame.size.height - 84
		let rect = CGRect(x: -width / 2, y: -height / 2, width: width, height: height)
		backGround = SKShapeNode(rect: rect, cornerRadius: 0.02)
		backGround.fillColor = SKColor.purple
		backGround.zPosition = 2
		backGround.isHidden = false
		self.addChild(backGround)
		
		createBoard(width: Int(width), height: Int(height))
	}
	
	private func theGameView5() {
		
		scores = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		scores.zPosition = 1
		scores.position = CGPoint(x: 0, y: (frame.size.height / +2) - 30)
		scores.fontSize = 30
		scores.isHidden = false
		scores.text = "0"
		scores.fontColor = SKColor.white
		self.scores.run(SKAction.scale(to: 1, duration: 0))
		self.addChild(scores)
		let width = frame.size.width - 25
		let height = frame.size.height - 84
		let rect = CGRect(x: -width / 2, y: -height / 2, width: width, height: height)
		backGround = SKShapeNode(rect: rect, cornerRadius: 0.02)
		backGround.fillColor = SKColor.white
		backGround.zPosition = 2
		backGround.isHidden = false
		self.addChild(backGround)
		
		createBoard(width: Int(width), height: Int(height))
	}
	
	private func theGameView6() {
        
		scores = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		scores.zPosition = 1
		scores.position = CGPoint(x: 0, y: (frame.size.height / +2) - 30)
		scores.fontSize = 30
		scores.isHidden = false
		scores.text = "0"
		scores.fontColor = SKColor.white
		self.scores.run(SKAction.scale(to: 1, duration: 0))
		self.addChild(scores)
		let width = frame.size.width - 25
		let height = frame.size.height - 84
		let rect = CGRect(x: -width / 2, y: -height / 2, width: width, height: height)
		backGround = SKShapeNode(rect: rect, cornerRadius: 0.02)
		backGround.fillColor = SKColor.yellow
		backGround.zPosition = 2
		backGround.isHidden = false
		self.addChild(backGround)
		
		createBoard(width: Int(width), height: Int(height))
	}
	
	private func iMenu() {
		
		bestScores = SKLabelNode(fontNamed: "Chalkduster")
		bestScores.zPosition = 1
		bestScores.position = CGPoint(x: 0, y: (frame.size.height / -2) + 15)
		bestScores.fontSize = 30
		bestScores.isHidden = false
		bestScores.text = "highscore: \(UserDefaults.standard.integer(forKey: "bestScores"))"
		bestScores.fontColor = SKColor.red
		self.addChild(bestScores)
		headLine = SKLabelNode(fontNamed: "Chalkduster")
		headLine.zPosition = 1
		headLine.position = CGPoint(x: -100, y: (frame.size.height / 2) - 400)
		headLine.fontSize = 20
		headLine.text = "contact"
		headLine.fontColor = SKColor.black
		self.headLine.run(SKAction.scale(to: 1, duration: 0))
		self.addChild(headLine)
		let paths = CGMutablePath()
		paths.addArc(center: CGPoint.zero,
					 radius: 75,
					 startAngle: 0,
					 endAngle: CGFloat.pi * 2,
					 clockwise: true)
		headLines = SKShapeNode(path: paths)
		headLines.name = "info"
		headLines.zPosition = 1
		headLines.position = CGPoint(x: -100, y: (frame.size.height / 2) - 390)
		headLines.lineWidth = 1
		headLines.fillColor = .yellow
		headLines.strokeColor = .black
		headLines.glowWidth = 3
		self.addChild(headLines)
		leaderboard = SKLabelNode(fontNamed: "Chalkduster")
		leaderboard.zPosition = 1
		leaderboard.position = CGPoint(x: 100, y: (frame.size.height / 2) - 400)
		leaderboard.fontSize = 20
		leaderboard.text = "leaderboard"
		leaderboard.fontColor = SKColor.black
		self.leaderboard.run(SKAction.scale(to: 1, duration: 0))
		self.addChild(leaderboard)
		paths.addArc(center: CGPoint.zero,
					 radius: 75,
					 startAngle: 0,
					 endAngle: CGFloat.pi * 2,
					 clockwise: true)
		leaderboards = SKShapeNode(path: paths)
		leaderboards.name = "leaderboards"
		leaderboards.zPosition = 1
		leaderboards.position = CGPoint(x: 100, y: (frame.size.height / 2) - 390)
		leaderboards.lineWidth = 1
		leaderboards.fillColor = .yellow
		leaderboards.strokeColor = .black
		leaderboards.glowWidth = 3
		self.addChild(leaderboards)
		instruction = SKLabelNode(fontNamed: "Chalkduster")
		instruction.zPosition = 1
		instruction.position = CGPoint(x: 325, y: (frame.size.height / 2) - 80)
		instruction.fontSize = 30
		instruction.text = "i"
		instruction.fontColor = SKColor.black
		self.instruction.run(SKAction.scale(to: 1, duration: 0))
		self.addChild(instruction)
		let paths1 = CGMutablePath()
		paths1.addArc(center: CGPoint.zero,
					 radius: 30,
					 startAngle: 0,
					 endAngle: CGFloat.pi * 2,
					 clockwise: true)
		instructions = SKShapeNode(path: paths1)
		instructions.name = "instructions"
		instructions.zPosition = 1
		instructions.position = CGPoint(x: 325, y: (frame.size.height / 2) - 70)
		instructions.lineWidth = 1
		instructions.fillColor = .yellow
		instructions.strokeColor = .black
		instructions.glowWidth = 3
		self.addChild(instructions)
		topLogo = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		topLogo.zPosition = 1
		topLogo.position = CGPoint(x: -250, y: (frame.size.height / 2) - 200)
		topLogo.fontSize = 100
		topLogo.text = "L"
		topLogo.fontColor = SKColor.blue
		self.addChild(topLogo)
		topLogo1 = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		topLogo1.zPosition = 1
		topLogo1.position = CGPoint(x: -185, y: (frame.size.height / 2) - 200)
		topLogo1.fontSize = 100
		topLogo1.text = "O"
		topLogo1.fontColor = SKColor.red
		self.addChild(topLogo1)
		topLogo2 = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		topLogo2.zPosition = 1
		topLogo2.position = CGPoint(x: -105, y: (frame.size.height / 2) - 200)
		topLogo2.fontSize = 100
		topLogo2.text = "O"
		topLogo2.fontColor = SKColor.cyan
		self.addChild(topLogo2)
		topLogo3 = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		topLogo3.zPosition = 1
		topLogo3.position = CGPoint(x: -35, y: (frame.size.height / 2) - 200)
		topLogo3.fontSize = 100
		topLogo3.text = "S"
		topLogo3.fontColor = SKColor.magenta
		self.addChild(topLogo3)
		topLogo4 = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		topLogo4.zPosition = 1
		topLogo4.position = CGPoint(x: 35, y: (frame.size.height / 2) - 200)
		topLogo4.fontSize = 100
		topLogo4.text = "E"
		topLogo4.fontColor = SKColor.green
		self.addChild(topLogo4)
		topLogo5 = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		topLogo5.zPosition = 1
		topLogo5.position = CGPoint(x: 102, y: (frame.size.height / 2) - 200)
		topLogo5.fontSize = 100
		topLogo5.text = "G"
		topLogo5.fontColor = SKColor.purple
		self.addChild(topLogo5)
		topLogo6 = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		topLogo6.zPosition = 1
		topLogo6.position = CGPoint(x: 178, y: (frame.size.height / 2) - 200)
		topLogo6.fontSize = 100
		topLogo6.text = "E"
		topLogo6.fontColor = SKColor.white
		self.addChild(topLogo6)
		topLogo7 = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		topLogo7.zPosition = 1
		topLogo7.position = CGPoint(x: 250, y: (frame.size.height / 2) - 200)
		topLogo7.fontSize = 100
		topLogo7.text = "M"
		topLogo7.fontColor = SKColor.orange
		self.addChild(topLogo7)
		cpuLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		cpuLabel.zPosition = 1
		cpuLabel.position = CGPoint(x: -150, y: (frame.size.height / 2) - 700)
		cpuLabel.fontSize = 30
		cpuLabel.text = "PLAY"
		cpuLabel.fontColor = SKColor.black
		self.cpuLabel.run(SKAction.scale(to: 1, duration: 0))
		self.addChild(cpuLabel)
		let path = CGMutablePath()
		path.addArc(center: CGPoint.zero,
					radius: 80,
					startAngle: 0,
					endAngle: CGFloat.pi * 2,
					clockwise: true)
		vsCPU = SKShapeNode(path: path)
		vsCPU.name = "vsCPU"
		vsCPU.zPosition = 1
		vsCPU.position = CGPoint(x: -150, y: (frame.size.height / 2) - 685)
		vsCPU.lineWidth = 1
		vsCPU.fillColor = .red
		vsCPU.strokeColor = .black
		vsCPU.glowWidth = 3
		self.addChild(vsCPU)
		rateLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		rateLabel.zPosition = 1
		rateLabel.position = CGPoint(x: 150, y: (frame.size.height / 2) - 700)
		rateLabel.fontSize = 30
		rateLabel.text = "RATE"
		rateLabel.fontColor = SKColor.black
		self.rateLabel.run(SKAction.scale(to: 1, duration: 0))
		self.addChild(rateLabel)
		path.addArc(center: CGPoint.zero,
					radius: 80,
					startAngle: 0,
					endAngle: CGFloat.pi * 2,
					clockwise: true)
		rate = SKShapeNode(path: path)
		rate.name = "rate"
		rate.zPosition = 1
		rate.position = CGPoint(x: 150, y: (frame.size.height / 2) - 685)
		rate.lineWidth = 1
		rate.fillColor = .red
		rate.strokeColor = .black
		rate.glowWidth = 3
		self.addChild(rate)
		shareLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		shareLabel.zPosition = 1
		shareLabel.position = CGPoint(x: 0, y: (frame.size.height / 2) - 900)
		shareLabel.fontSize = 30
		shareLabel.text = "SHARE"
		shareLabel.fontColor = SKColor.black
		self.shareLabel.run(SKAction.scale(to: 1, duration: 0))
		self.addChild(shareLabel)
		path.addArc(center: CGPoint.zero,
					radius: 80,
					startAngle: 0,
					endAngle: CGFloat.pi * 2,
					clockwise: true)
		share = SKShapeNode(path: path)
		share.name = "share"
		share.zPosition = 1
		share.position = CGPoint(x: 0, y: (frame.size.height / 2) - 885)
		share.lineWidth = 1
		share.fillColor = .red
		share.strokeColor = .black
		share.glowWidth = 3
		self.addChild(share)
	}
	
	private func instructionMenu() {
		
		instructionColor = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		instructionColor.zPosition = 1
		instructionColor.position = CGPoint(x: 0, y: (frame.size.height / 2) - 300)
		instructionColor.fontSize = 30
		instructionColor.isHidden = false
		instructionColor.text = "HOW TO PLAY"
		instructionColor.fontColor = SKColor.red
		self.addChild(instructionColor)
		
		instructionColor1 = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		instructionColor1.zPosition = 1
		instructionColor1.position = CGPoint(x: 0, y: (frame.size.height / 2) - 350)
		instructionColor1.fontSize = 30
		instructionColor1.isHidden = false
		instructionColor1.text = "Swipe left, right, up, down to navigate"
		instructionColor1.fontColor = SKColor.white
		self.addChild(instructionColor1)
		
		instructionColor2 = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		instructionColor2.zPosition = 1
		instructionColor2.position = CGPoint(x: 0, y: (frame.size.height / 2) - 400)
		instructionColor2.fontSize = 30
		instructionColor2.isHidden = false
		instructionColor2.text = "Get as many points as possible"
		instructionColor2.fontColor = SKColor.white
		self.addChild(instructionColor2)
		
		instructionColor3 = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		instructionColor3.zPosition = 1
		instructionColor3.position = CGPoint(x: 0, y: (frame.size.height / 2) - 450)
		instructionColor3.fontSize = 30
		instructionColor3.isHidden = false
		instructionColor3.text = "Green gems: +1, Black gems: +0, Red gems: -1"
		instructionColor3.fontColor = SKColor.white
		self.addChild(instructionColor3)
		
		instructionColor4 = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		instructionColor4.zPosition = 1
		instructionColor4.position = CGPoint(x: 0, y: (frame.size.height / 2) - 500)
		instructionColor4.fontSize = 30
		instructionColor4.isHidden = false
		instructionColor4.text = "The LOOSE GEM (red) always carries +5"
		instructionColor4.fontColor = SKColor.white
		self.addChild(instructionColor4)
		
		instructionColor5 = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		instructionColor5.zPosition = 1
		instructionColor5.position = CGPoint(x: 0, y: (frame.size.height / 2) - 550)
		instructionColor5.fontSize = 30
		instructionColor5.isHidden = false
		instructionColor5.text = "Green & black gems increase character length"
		instructionColor5.fontColor = SKColor.white
		self.addChild(instructionColor5)
		
		instructionColor6 = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		instructionColor6.zPosition = 1
		instructionColor6.position = CGPoint(x: 0, y: (frame.size.height / 2) - 600)
		instructionColor6.fontSize = 30
		instructionColor6.isHidden = false
		instructionColor6.text = "Game ends when character touches itself"
		instructionColor6.fontColor = SKColor.white
		self.addChild(instructionColor6)
		
		instructionColor0 = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		instructionColor0.zPosition = 1
		instructionColor0.position = CGPoint(x: 0, y: (frame.size.height / 2) - 700)
		instructionColor0.fontSize = 30
		instructionColor0.isHidden = false
		instructionColor0.text = "HOW TO CONNECT TO GAME CENTER"
		instructionColor0.fontColor = SKColor.red
		self.addChild(instructionColor0)
		
		instructionColor01 = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		instructionColor01.zPosition = 1
		instructionColor01.position = CGPoint(x: 0, y: (frame.size.height / 2) - 750)
		instructionColor01.fontSize = 30
		instructionColor01.isHidden = false
		instructionColor01.text = "Go to Settings on iPhone/iPad"
		instructionColor01.fontColor = SKColor.white
		self.addChild(instructionColor01)
		
		instructionColor02 = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		instructionColor02.zPosition = 1
		instructionColor02.position = CGPoint(x: 0, y: (frame.size.height / 2) - 800)
		instructionColor02.fontSize = 30
		instructionColor02.isHidden = false
		instructionColor02.text = "Go to Game Center"
		instructionColor02.fontColor = SKColor.white
		self.addChild(instructionColor02)
		
		instructionColor03 = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		instructionColor03.zPosition = 1
		instructionColor03.position = CGPoint(x: 0, y: (frame.size.height / 2) - 850)
		instructionColor03.fontSize = 30
		instructionColor03.isHidden = false
		instructionColor03.text = "Turn on Game Center and choose a username"
		instructionColor03.fontColor = SKColor.white
		self.addChild(instructionColor03)
		
		menu1Label = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		menu1Label.zPosition = 1
		menu1Label.position = CGPoint(x: 0, y: (frame.size.height / 2) - 1000)
		menu1Label.fontSize = 30
		menu1Label.text = "MENU"
		menu1Label.fontColor = SKColor.black
		self.menu1Label.run(SKAction.scale(to: 1, duration: 0))
		self.addChild(menu1Label)
		let path = CGMutablePath()
		path.addArc(center: CGPoint.zero,
					radius: 80,
					startAngle: 0,
					endAngle: CGFloat.pi * 2,
					clockwise: true)
		menu1 = SKShapeNode(path: path)
		menu1.name = "menu1"
		menu1.zPosition = 1
		menu1.position = CGPoint(x: 0, y: (frame.size.height / 2) - 985)
		menu1.lineWidth = 1
		menu1.fillColor = .red
		menu1.strokeColor = .black
		menu1.glowWidth = 3
		self.addChild(menu1)
		
		vsCPU.run(SKAction.scale(to: 0, duration: 0)) {
			self.vsCPU.isHidden = true
		}
		
		self.cpuLabel.isHidden = true
		
		rate.run(SKAction.scale(to: 0, duration: 0)) {
			self.rate.isHidden = true
		}
		
		self.rateLabel.isHidden = true
		
		share.run(SKAction.scale(to: 0, duration: 0)) {
			self.share.isHidden = true
		}
		
		self.shareLabel.isHidden = true
		self.bestScores.isHidden = true
		self.headLine.isHidden = true
		self.headLines.isHidden = true
		self.leaderboard.isHidden = true
		self.leaderboards.isHidden = true
		self.instruction.isHidden = true
		self.instructions.isHidden = true
		
	}
	
	private func colorMenu() {
		
		bgColor = SKLabelNode(fontNamed: "Chalkduster")
		bgColor.zPosition = 1
		bgColor.position = CGPoint(x: 0, y: (frame.size.height / -2) + 100)
		bgColor.fontSize = 30
		bgColor.isHidden = false
		bgColor.text = "choose background color"
		bgColor.fontColor = SKColor.red
		self.addChild(bgColor)
		
		vsCPU.run(SKAction.scale(to: 0, duration: 0)) {
			self.vsCPU.isHidden = true
		}
		
		self.cpuLabel.isHidden = true
		
		rate.run(SKAction.scale(to: 0, duration: 0)) {
			self.rate.isHidden = true
		}
		
		self.rateLabel.isHidden = true
		
		share.run(SKAction.scale(to: 0, duration: 0)) {
			self.share.isHidden = true
		}
		
		self.shareLabel.isHidden = true
		self.bestScores.isHidden = true
		self.headLine.isHidden = true
		self.headLines.isHidden = true
		self.leaderboard.isHidden = true
		self.leaderboards.isHidden = true
		
		brownLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		brownLabel.zPosition = 1
		brownLabel.position = CGPoint(x: -200, y: (frame.size.height / 2) - 900)
		brownLabel.fontSize = 30
		brownLabel.text = "BROWN"
		brownLabel.fontColor = SKColor.black
		self.brownLabel.run(SKAction.scale(to: 1, duration: 0))
		self.addChild(brownLabel)
		let path = CGMutablePath()
		path.addArc(center: CGPoint.zero,
					radius: 80,
					startAngle: 0,
					endAngle: CGFloat.pi * 2,
					clockwise: true)
		brown = SKShapeNode(path: path)
		brown.name = "brown"
		brown.zPosition = 1
		brown.position = CGPoint(x: -200, y: (frame.size.height / 2) - 885)
		brown.lineWidth = 1
		brown.fillColor = .brown
		brown.strokeColor = .black
		brown.glowWidth = 3
		self.addChild(brown)
		blueLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		blueLabel.zPosition = 1
		blueLabel.position = CGPoint(x: 200, y: (frame.size.height / 2) - 900)
		blueLabel.fontSize = 30
		blueLabel.text = "BLUE"
		blueLabel.fontColor = SKColor.black
		self.blueLabel.run(SKAction.scale(to: 1, duration: 0))
		self.addChild(blueLabel)
		path.addArc(center: CGPoint.zero,
					radius: 80,
					startAngle: 0,
					endAngle: CGFloat.pi * 2,
					clockwise: true)
		blue = SKShapeNode(path: path)
		blue.name = "blue"
		blue.zPosition = 1
		blue.position = CGPoint(x: 200, y: (frame.size.height / 2) - 885)
		blue.lineWidth = 1
		blue.fillColor = .blue
		blue.strokeColor = .black
		blue.glowWidth = 3
		self.addChild(blue)
		cyanLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		cyanLabel.zPosition = 1
		cyanLabel.position = CGPoint(x: -200, y: (frame.size.height / 2) - 700)
		cyanLabel.fontSize = 30
		cyanLabel.text = "CYAN"
		cyanLabel.fontColor = SKColor.black
		self.cyanLabel.run(SKAction.scale(to: 1, duration: 0))
		self.addChild(cyanLabel)
		path.addArc(center: CGPoint.zero,
					radius: 80,
					startAngle: 0,
					endAngle: CGFloat.pi * 2,
					clockwise: true)
		cyan = SKShapeNode(path: path)
		cyan.name = "cyan"
		cyan.zPosition = 1
		cyan.position = CGPoint(x: -200, y: (frame.size.height / 2) - 685)
		cyan.lineWidth = 1
		cyan.fillColor = .cyan
		cyan.strokeColor = .black
		cyan.glowWidth = 3
		self.addChild(cyan)
		magentaLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		magentaLabel.zPosition = 1
		magentaLabel.position = CGPoint(x: 200, y: (frame.size.height / 2) - 700)
		magentaLabel.fontSize = 30
		magentaLabel.text = "MAGENTA"
		magentaLabel.fontColor = SKColor.black
		self.magentaLabel.run(SKAction.scale(to: 1, duration: 0))
		self.addChild(magentaLabel)
		path.addArc(center: CGPoint.zero,
					radius: 80,
					startAngle: 0,
					endAngle: CGFloat.pi * 2,
					clockwise: true)
		magenta = SKShapeNode(path: path)
		magenta.name = "magenta"
		magenta.zPosition = 1
		magenta.position = CGPoint(x: 200, y: (frame.size.height / 2) - 685)
		magenta.lineWidth = 1
		magenta.fillColor = .magenta
		magenta.strokeColor = .black
		magenta.glowWidth = 3
		self.addChild(magenta)
		purpleLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		purpleLabel.zPosition = 1
		purpleLabel.position = CGPoint(x: -200, y: (frame.size.height / 2) - 500)
		purpleLabel.fontSize = 30
		purpleLabel.text = "PURPLE"
		purpleLabel.fontColor = SKColor.black
		self.purpleLabel.run(SKAction.scale(to: 1, duration: 0))
		self.addChild(purpleLabel)
		path.addArc(center: CGPoint.zero,
					radius: 80,
					startAngle: 0,
					endAngle: CGFloat.pi * 2,
					clockwise: true)
		purple = SKShapeNode(path: path)
		purple.name = "purple"
		purple.zPosition = 1
		purple.position = CGPoint(x: -200, y: (frame.size.height / 2) - 485)
		purple.lineWidth = 1
		purple.fillColor = .purple
		purple.strokeColor = .black
		purple.glowWidth = 3
		self.addChild(purple)
		whiteLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		whiteLabel.zPosition = 1
		whiteLabel.position = CGPoint(x: 200, y: (frame.size.height / 2) - 500)
		whiteLabel.fontSize = 30
		whiteLabel.text = "WHITE"
		whiteLabel.fontColor = SKColor.black
		self.whiteLabel.run(SKAction.scale(to: 1, duration: 0))
		self.addChild(whiteLabel)
		path.addArc(center: CGPoint.zero,
					radius: 80,
					startAngle: 0,
					endAngle: CGFloat.pi * 2,
					clockwise: true)
		white = SKShapeNode(path: path)
		white.name = "white"
		white.zPosition = 1
		white.position = CGPoint(x: 200, y: (frame.size.height / 2) - 485)
		white.lineWidth = 1
		white.fillColor = .white
		white.strokeColor = .black
		white.glowWidth = 3
		self.addChild(white)
		yellowLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		yellowLabel.zPosition = 1
		yellowLabel.position = CGPoint(x: 0, y: (frame.size.height / 2) - 400)
		yellowLabel.fontSize = 30
		yellowLabel.text = "YELLOW"
		yellowLabel.fontColor = SKColor.black
		self.yellowLabel.run(SKAction.scale(to: 1, duration: 0))
		self.addChild(yellowLabel)
		path.addArc(center: CGPoint.zero,
					radius: 80,
					startAngle: 0,
					endAngle: CGFloat.pi * 2,
					clockwise: true)
		yellow = SKShapeNode(path: path)
		yellow.name = "yellow"
		yellow.zPosition = 1
		yellow.position = CGPoint(x: 0, y: (frame.size.height / 2) - 385)
		yellow.lineWidth = 1
		yellow.fillColor = .yellow
		yellow.strokeColor = .black
		yellow.glowWidth = 3
		self.addChild(yellow)
		
		menuLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
		menuLabel.zPosition = 1
		menuLabel.position = CGPoint(x: 0, y: (frame.size.height / 2) - 1000)
		menuLabel.fontSize = 30
		menuLabel.text = "MENU"
		menuLabel.fontColor = SKColor.black
		self.menuLabel.run(SKAction.scale(to: 1, duration: 0))
		self.addChild(menuLabel)
		path.addArc(center: CGPoint.zero,
					radius: 80,
					startAngle: 0,
					endAngle: CGFloat.pi * 2,
					clockwise: true)
		menu = SKShapeNode(path: path)
		menu.name = "menu"
		menu.zPosition = 1
		menu.position = CGPoint(x: 0, y: (frame.size.height / 2) - 985)
		menu.lineWidth = 1
		menu.fillColor = .red
		menu.strokeColor = .black
		menu.glowWidth = 3
		self.addChild(menu)
	}
	
	private func ratePage() {
		
		let appID = "1426831523"
		let urlStr = "itms-apps://itunes.apple.com/app/viewContentsUserReviews?id=" + (appID)
		
		if let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) {
			if #available(iOS 11.4, *) {
				UIApplication.shared.open(url, options: [:], completionHandler: nil)
			} else {
				UIApplication.shared.openURL(url)
			}
		}
	}
	
	private func sharePage() {
		
		let text = "Check out Loose Gem, it's challenging and fun!"
		let appID = "1426831523"
		let url = URL(string: "itms-apps://itunes.apple.com/us/app/loose-gem/id" + (appID) + "?mt=8")!
		
		let vc = UIActivityViewController(activityItems: [text, url], applicationActivities: nil)
		vc.popoverPresentationController?.sourceView = self.view
		
		self.view?.window?.rootViewController?.present(vc, animated: true, completion: nil)
		
	}
	
	private func infoPage() {
		
		let email = "jidejakes@gmail.com"
		if let url = URL(string: "mailto:\(email)") {
			if #available(iOS 11.4, *) {
				UIApplication.shared.open(url)
			} else {
				UIApplication.shared.openURL(url)
			}
		}
	}
}
