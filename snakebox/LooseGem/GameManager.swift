//  GameManager.swift
//  LooseGem
//  Created by jidejakes on 08/08/2018.
//  Copyright © 2018 jidejakes. All rights reserved.

import SpriteKit

class GameManager {
    
    var scene: GameScene!
    var nextTime: Double?
    var timePlus: Double = 0.055
    var playerDirection: Int = 4
    var scoreNow: Int = 0
    
    init(scene: GameScene) {
        self.scene = scene
    }
    
    func theGame() {
        
        scene.playerPositions.append((14, 14))
        scene.playerPositions.append((14, 15))
        scene.playerPositions.append((14, 16))
        
        ourNewPoint1()
        ourNewPoint2()
        ourNewPoint3()
        ourNewPoint4()
        ourNewPoint5()
        ourNewPoint6()
        ourNewPoint7()
        ourNewPoint8()
        ourNewPoint9()
        ourNewPoint0()
        ourNewPoint01()
        ourNewPoint02()
        ourNewPoint03()
        ourNewPoint04()
        ourNewPoint05()
        ourNewPoint06()
        ourNewPoint07()
        ourNewPoint08()
        ourNewPoint09()
        ourNewPoint00()
        ourNewPoint001()
        ourNewPoint002()
        ourNewPoint003()
        
    }
    
    private func endGame() {
        if playerDirection == 5 && scene.playerPositions.count > 0 {
            var gameDone = true
            self.scene.cpuLabel.isHidden = true
            self.scene.scores.isHidden = false
            let theHead = scene.playerPositions[0]
            for position in scene.playerPositions {
                if theHead != position {
                    gameDone = false
                }
                newScoring()
            }
            
            if gameDone {
                playerDirection = 4
                scene.scoreP1 = nil
                scene.playerPositions.removeAll()
                scene.scoreP2 = nil
                scene.playerPositions.removeAll()
                scene.scoreP3 = nil
                scene.playerPositions.removeAll()
                scene.scoreP4 = nil
                scene.playerPositions.removeAll()
                scene.scoreP5 = nil
                scene.playerPositions.removeAll()
                scene.scoreP6 = nil
                scene.playerPositions.removeAll()
                scene.scoreP7 = nil
                scene.playerPositions.removeAll()
                scene.scoreP8 = nil
                scene.playerPositions.removeAll()
                scene.scoreP9 = nil
                scene.playerPositions.removeAll()
                scene.scoreP0 = nil
                scene.playerPositions.removeAll()
                scene.scoreP01 = nil
                scene.playerPositions.removeAll()
                scene.scoreP02 = nil
                scene.playerPositions.removeAll()
                scene.scoreP03 = nil
                scene.playerPositions.removeAll()
                scene.scoreP04 = nil
                scene.playerPositions.removeAll()
                scene.scoreP05 = nil
                scene.playerPositions.removeAll()
                scene.scoreP06 = nil
                scene.playerPositions.removeAll()
                scene.scoreP07 = nil
                scene.playerPositions.removeAll()
                scene.scoreP08 = nil
                scene.playerPositions.removeAll()
                scene.scoreP09 = nil
                scene.playerPositions.removeAll()
                scene.scoreP00 = nil
                scene.playerPositions.removeAll()
                scene.scoreP001 = nil
                scene.playerPositions.removeAll()
                scene.scoreP002 = nil
                scene.playerPositions.removeAll()
                scene.scoreP003 = nil
                scene.playerPositions.removeAll()
                
                doChange()
                
                self.scene.scores.run(SKAction.scale(to: 0, duration: 0))
                
                    self.scene.backGround.run(SKAction.scale(to: 0, duration: 0)) {
                        
                            self.scene.vsCPU.isHidden = false
                            self.scene.vsCPU.run(SKAction.scale(to: 1, duration: 0))
                            self.scene.cpuLabel.isHidden = false
                            self.scene.cpuLabel.run(SKAction.move(to: CGPoint(x: -150, y: (self.scene.frame.size.height / 2) - 700), duration: 0))
                            
                            self.scene.rate.isHidden = false
                            self.scene.rate.run(SKAction.scale(to: 1, duration: 0))
                            self.scene.rateLabel.isHidden = false
                            self.scene.rateLabel.run(SKAction.move(to: CGPoint(x: 150, y: (self.scene.frame.size.height / 2) - 700), duration: 0))
                            
                            self.scene.share.isHidden = false
                            self.scene.share.run(SKAction.scale(to: 1, duration: 0))
                            self.scene.shareLabel.isHidden = false
                            self.scene.shareLabel.run(SKAction.move(to: CGPoint(x: 0, y: (self.scene.frame.size.height / 2) - 900), duration: 0))
                            
                            self.scene.headLine.run(SKAction.scale(to: 1, duration: 0))
                            self.scene.headLines.run(SKAction.scale(to: 1, duration: 0))
                            
                            self.scene.bestScores.isHidden = false
                            self.scene.headLine.isHidden = false
                            self.scene.headLines.isHidden = false
                            self.scene.leaderboard.isHidden = false
                            self.scene.leaderboards.isHidden = false
                            self.scene.instruction.isHidden = false
                            self.scene.instructions.isHidden = false
                }
            }
        }
    }
    
    func moves(ID: Int) {
        if !(ID == 2 && playerDirection == 4) && !(ID == 4 && playerDirection == 2) {
            if !(ID == 1 && playerDirection == 3) && !(ID == 3 && playerDirection == 1) {
                if playerDirection != 5 {
                    playerDirection = ID
                }
            }
        }
    }
    
    private func newScoring() {
        if scoreNow > UserDefaults.standard.integer(forKey: "bestScores") {
            UserDefaults.standard.set(scoreNow, forKey: "bestScores")
            scene.bestScores.text = "highscore: \(UserDefaults.standard.integer(forKey: "bestScores"))"
        }
        
        scoreNow = 0
        
    }
    
    private func checkScores() {
        
        if scene.scoreP1 != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scoreP1?.x)!) == y && Int((scene.scoreP1?.y)!) == x {
                scoreNow += 1
                scene.scores.text = "\(scoreNow)"
                ourNewPoint1()
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
            }
        }
        
        if scene.scoreP2 != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scoreP2?.x)!) == y && Int((scene.scoreP2?.y)!) == x {
                scoreNow += 0
                scene.scores.text = "\(scoreNow)"
                ourNewPoint2()
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
            }
        }
        
        if scene.scoreP3 != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scoreP3?.x)!) == y && Int((scene.scoreP3?.y)!) == x {
                scoreNow += 0
                scene.scores.text = "\(scoreNow)"
                ourNewPoint3()
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
            }
        }
        
        if scene.scoreP4 != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scoreP4?.x)!) == y && Int((scene.scoreP4?.y)!) == x {
                scoreNow += 0
                scene.scores.text = "\(scoreNow)"
                ourNewPoint4()
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
            }
        }
        
        if scene.scoreP5 != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scoreP5?.x)!) == y && Int((scene.scoreP5?.y)!) == x {
                scoreNow += 1
                scene.scores.text = "\(scoreNow)"
                ourNewPoint5()
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
            }
        }
        
        if scene.scoreP6 != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scoreP6?.x)!) == y && Int((scene.scoreP6?.y)!) == x {
                scoreNow -= 1
                scene.scores.text = "\(scoreNow)"
                ourNewPoint6()
            }
        }
        
        if scene.scoreP7 != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scoreP7?.x)!) == y && Int((scene.scoreP7?.y)!) == x {
                scoreNow -= 1
                scene.scores.text = "\(scoreNow)"
                ourNewPoint7()
            }
        }
        
        if scene.scoreP8 != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scoreP8?.x)!) == y && Int((scene.scoreP8?.y)!) == x {
                scoreNow -= 1
                scene.scores.text = "\(scoreNow)"
                ourNewPoint8()
            }
        }
        
        if scene.scoreP9 != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scoreP9?.x)!) == y && Int((scene.scoreP9?.y)!) == x {
                scoreNow -= 1
                scene.scores.text = "\(scoreNow)"
                ourNewPoint9()
            }
        }
        
        if scene.scoreP0 != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scoreP0?.x)!) == y && Int((scene.scoreP0?.y)!) == x {
                scoreNow += 0
                scene.scores.text = "\(scoreNow)"
                ourNewPoint0()
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
            }
        }
        
        if scene.scoreP01 != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scoreP01?.x)!) == y && Int((scene.scoreP01?.y)!) == x {
                scoreNow += 1
                scene.scores.text = "\(scoreNow)"
                ourNewPoint01()
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
            }
        }
        
        if scene.scoreP02 != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scoreP02?.x)!) == y && Int((scene.scoreP02?.y)!) == x {
                scoreNow -= 1
                scene.scores.text = "\(scoreNow)"
                ourNewPoint02()
            }
        }
        
        if scene.scoreP03 != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scoreP03?.x)!) == y && Int((scene.scoreP03?.y)!) == x {
                scoreNow -= 1
                scene.scores.text = "\(scoreNow)"
                ourNewPoint03()
            }
        }
        
        if scene.scoreP04 != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scoreP04?.x)!) == y && Int((scene.scoreP04?.y)!) == x {
                scoreNow -= 1
                scene.scores.text = "\(scoreNow)"
                ourNewPoint04()
            }
        }
        
        if scene.scoreP05 != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scoreP05?.x)!) == y && Int((scene.scoreP05?.y)!) == x {
                scoreNow -= 1
                scene.scores.text = "\(scoreNow)"
                ourNewPoint05()
            }
        }
        
        if scene.scoreP06 != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scoreP06?.x)!) == y && Int((scene.scoreP06?.y)!) == x {
                scoreNow -= 1
                scene.scores.text = "\(scoreNow)"
                ourNewPoint06()
            }
        }
        
        if scene.scoreP07 != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scoreP07?.x)!) == y && Int((scene.scoreP07?.y)!) == x {
                scoreNow -= 1
                scene.scores.text = "\(scoreNow)"
                ourNewPoint07()
            }
        }
        
        if scene.scoreP08 != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scoreP08?.x)!) == y && Int((scene.scoreP08?.y)!) == x {
                scoreNow -= 1
                scene.scores.text = "\(scoreNow)"
                ourNewPoint08()
            }
        }
        
        if scene.scoreP09 != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scoreP09?.x)!) == y && Int((scene.scoreP09?.y)!) == x {
                scoreNow += 5
                scene.scores.text = "\(scoreNow)"
                ourNewPoint09()
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
            }
        }
        
        if scene.scoreP00 != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scoreP00?.x)!) == y && Int((scene.scoreP00?.y)!) == x {
                scoreNow += 0
                scene.scores.text = "\(scoreNow)"
                ourNewPoint00()
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
            }
        }
        
        if scene.scoreP001 != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scoreP001?.x)!) == y && Int((scene.scoreP001?.y)!) == x {
                scoreNow -= 1
                scene.scores.text = "\(scoreNow)"
                ourNewPoint001()
            }
        }
        
        if scene.scoreP002 != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scoreP002?.x)!) == y && Int((scene.scoreP002?.y)!) == x {
                scoreNow += 1
                scene.scores.text = "\(scoreNow)"
                ourNewPoint002()
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
            }
        }
        
        if scene.scoreP003 != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.scoreP003?.x)!) == y && Int((scene.scoreP003?.y)!) == x {
                scoreNow -= 1
                scene.scores.text = "\(scoreNow)"
                ourNewPoint003()
            }
        }
    }
    
    private func ourNewPoint1() {
        var randomX1 = CGFloat(arc4random_uniform(28))
        var randomY1 = CGFloat(arc4random_uniform(49))
        while contains(a: scene.playerPositions, v: (Int(randomX1), Int(randomY1))) {
            randomX1 = CGFloat(arc4random_uniform(28))
            randomY1 = CGFloat(arc4random_uniform(49))
        }
        scene.scoreP1 = CGPoint(x: randomX1, y: randomY1)
    }
    
    private func ourNewPoint2() {
        var randomX2 = CGFloat(arc4random_uniform(28))
        var randomY2 = CGFloat(arc4random_uniform(49))
        while contains(a: scene.playerPositions, v: (Int(randomX2), Int(randomY2))) {
            randomX2 = CGFloat(arc4random_uniform(28))
            randomY2 = CGFloat(arc4random_uniform(49))
        }
        scene.scoreP2 = CGPoint(x: randomX2, y: randomY2)
    }
    
    private func ourNewPoint3() {
        var randomX3 = CGFloat(arc4random_uniform(28))
        var randomY3 = CGFloat(arc4random_uniform(49))
        while contains(a: scene.playerPositions, v: (Int(randomX3), Int(randomY3))) {
            randomX3 = CGFloat(arc4random_uniform(28))
            randomY3 = CGFloat(arc4random_uniform(49))
        }
        scene.scoreP3 = CGPoint(x: randomX3, y: randomY3)
    }
    
    private func ourNewPoint4() {
        var randomX4 = CGFloat(arc4random_uniform(28))
        var randomY4 = CGFloat(arc4random_uniform(49))
        while contains(a: scene.playerPositions, v: (Int(randomX4), Int(randomY4))) {
            randomX4 = CGFloat(arc4random_uniform(28))
            randomY4 = CGFloat(arc4random_uniform(49))
        }
        scene.scoreP4 = CGPoint(x: randomX4, y: randomY4)
    }
    
    private func ourNewPoint5() {
        var randomX5 = CGFloat(arc4random_uniform(28))
        var randomY5 = CGFloat(arc4random_uniform(49))
        while contains(a: scene.playerPositions, v: (Int(randomX5), Int(randomY5))) {
            randomX5 = CGFloat(arc4random_uniform(28))
            randomY5 = CGFloat(arc4random_uniform(49))
        }
        scene.scoreP5 = CGPoint(x: randomX5, y: randomY5)
    }
    
    private func ourNewPoint6() {
        var randomX6 = CGFloat(arc4random_uniform(28))
        var randomY6 = CGFloat(arc4random_uniform(49))
        while contains(a: scene.playerPositions, v: (Int(randomX6), Int(randomY6))) {
            randomX6 = CGFloat(arc4random_uniform(28))
            randomY6 = CGFloat(arc4random_uniform(49))
        }
        scene.scoreP6 = CGPoint(x: randomX6, y: randomY6)
    }
    
    private func ourNewPoint7() {
        var randomX7 = CGFloat(arc4random_uniform(28))
        var randomY7 = CGFloat(arc4random_uniform(49))
        while contains(a: scene.playerPositions, v: (Int(randomX7), Int(randomY7))) {
            randomX7 = CGFloat(arc4random_uniform(28))
            randomY7 = CGFloat(arc4random_uniform(49))
        }
        scene.scoreP7 = CGPoint(x: randomX7, y: randomY7)
    }
    
    private func ourNewPoint8() {
        var randomX8 = CGFloat(arc4random_uniform(28))
        var randomY8 = CGFloat(arc4random_uniform(49))
        while contains(a: scene.playerPositions, v: (Int(randomX8), Int(randomY8))) {
            randomX8 = CGFloat(arc4random_uniform(28))
            randomY8 = CGFloat(arc4random_uniform(49))
        }
        scene.scoreP8 = CGPoint(x: randomX8, y: randomY8)
    }
    
    private func ourNewPoint9() {
        var randomX9 = CGFloat(arc4random_uniform(28))
        var randomY9 = CGFloat(arc4random_uniform(49))
        while contains(a: scene.playerPositions, v: (Int(randomX9), Int(randomY9))) {
            randomX9 = CGFloat(arc4random_uniform(28))
            randomY9 = CGFloat(arc4random_uniform(49))
        }
        scene.scoreP9 = CGPoint(x: randomX9, y: randomY9)
    }
    
    private func ourNewPoint0() {
        var randomX0 = CGFloat(arc4random_uniform(28))
        var randomY0 = CGFloat(arc4random_uniform(49))
        while contains(a: scene.playerPositions, v: (Int(randomX0), Int(randomY0))) {
            randomX0 = CGFloat(arc4random_uniform(28))
            randomY0 = CGFloat(arc4random_uniform(49))
        }
        scene.scoreP0 = CGPoint(x: randomX0, y: randomY0)
    }
    
    private func ourNewPoint01() {
        var randomX01 = CGFloat(arc4random_uniform(28))
        var randomY01 = CGFloat(arc4random_uniform(49))
        while contains(a: scene.playerPositions, v: (Int(randomX01), Int(randomY01))) {
            randomX01 = CGFloat(arc4random_uniform(28))
            randomY01 = CGFloat(arc4random_uniform(49))
        }
        scene.scoreP01 = CGPoint(x: randomX01, y: randomY01)
    }
    
    private func ourNewPoint02() {
        var randomX02 = CGFloat(arc4random_uniform(28))
        var randomY02 = CGFloat(arc4random_uniform(49))
        while contains(a: scene.playerPositions, v: (Int(randomX02), Int(randomY02))) {
            randomX02 = CGFloat(arc4random_uniform(28))
            randomY02 = CGFloat(arc4random_uniform(49))
        }
        scene.scoreP02 = CGPoint(x: randomX02, y: randomY02)
    }
    
    private func ourNewPoint03() {
        var randomX03 = CGFloat(arc4random_uniform(28))
        var randomY03 = CGFloat(arc4random_uniform(49))
        while contains(a: scene.playerPositions, v: (Int(randomX03), Int(randomY03))) {
            randomX03 = CGFloat(arc4random_uniform(28))
            randomY03 = CGFloat(arc4random_uniform(49))
        }
        scene.scoreP03 = CGPoint(x: randomX03, y: randomY03)
    }
    
    private func ourNewPoint04() {
        var randomX04 = CGFloat(arc4random_uniform(28))
        var randomY04 = CGFloat(arc4random_uniform(49))
        while contains(a: scene.playerPositions, v: (Int(randomX04), Int(randomY04))) {
            randomX04 = CGFloat(arc4random_uniform(28))
            randomY04 = CGFloat(arc4random_uniform(49))
        }
        scene.scoreP04 = CGPoint(x: randomX04, y: randomY04)
    }
    
    private func ourNewPoint05() {
        var randomX05 = CGFloat(arc4random_uniform(28))
        var randomY05 = CGFloat(arc4random_uniform(49))
        while contains(a: scene.playerPositions, v: (Int(randomX05), Int(randomY05))) {
            randomX05 = CGFloat(arc4random_uniform(28))
            randomY05 = CGFloat(arc4random_uniform(49))
        }
        scene.scoreP05 = CGPoint(x: randomX05, y: randomY05)
    }
    
    private func ourNewPoint06() {
        var randomX06 = CGFloat(arc4random_uniform(28))
        var randomY06 = CGFloat(arc4random_uniform(49))
        while contains(a: scene.playerPositions, v: (Int(randomX06), Int(randomY06))) {
            randomX06 = CGFloat(arc4random_uniform(28))
            randomY06 = CGFloat(arc4random_uniform(49))
        }
        scene.scoreP06 = CGPoint(x: randomX06, y: randomY06)
    }
    
    private func ourNewPoint07() {
        var randomX07 = CGFloat(arc4random_uniform(28))
        var randomY07 = CGFloat(arc4random_uniform(49))
        while contains(a: scene.playerPositions, v: (Int(randomX07), Int(randomY07))) {
            randomX07 = CGFloat(arc4random_uniform(28))
            randomY07 = CGFloat(arc4random_uniform(49))
        }
        scene.scoreP07 = CGPoint(x: randomX07, y: randomY07)
    }
    
    private func ourNewPoint08() {
        var randomX08 = CGFloat(arc4random_uniform(28))
        var randomY08 = CGFloat(arc4random_uniform(49))
        while contains(a: scene.playerPositions, v: (Int(randomX08), Int(randomY08))) {
            randomX08 = CGFloat(arc4random_uniform(28))
            randomY08 = CGFloat(arc4random_uniform(49))
        }
        scene.scoreP08 = CGPoint(x: randomX08, y: randomY08)
    }
    
    private func ourNewPoint09() {
        var randomX09 = CGFloat(arc4random_uniform(28))
        var randomY09 = CGFloat(arc4random_uniform(49))
        while contains(a: scene.playerPositions, v: (Int(randomX09), Int(randomY09))) {
            randomX09 = CGFloat(arc4random_uniform(28))
            randomY09 = CGFloat(arc4random_uniform(49))
        }
        scene.scoreP09 = CGPoint(x: randomX09, y: randomY09)
    }
    
    private func ourNewPoint00() {
        var randomX00 = CGFloat(arc4random_uniform(28))
        var randomY00 = CGFloat(arc4random_uniform(49))
        while contains(a: scene.playerPositions, v: (Int(randomX00), Int(randomY00))) {
            randomX00 = CGFloat(arc4random_uniform(28))
            randomY00 = CGFloat(arc4random_uniform(49))
        }
        scene.scoreP00 = CGPoint(x: randomX00, y: randomY00)
    }
    
    private func ourNewPoint001() {
        var randomX001 = CGFloat(arc4random_uniform(28))
        var randomY001 = CGFloat(arc4random_uniform(49))
        while contains(a: scene.playerPositions, v: (Int(randomX001), Int(randomY001))) {
            randomX001 = CGFloat(arc4random_uniform(28))
            randomY001 = CGFloat(arc4random_uniform(49))
        }
        scene.scoreP001 = CGPoint(x: randomX001, y: randomY001)
    }
    
    private func ourNewPoint002() {
        var randomX002 = CGFloat(arc4random_uniform(28))
        var randomY002 = CGFloat(arc4random_uniform(49))
        while contains(a: scene.playerPositions, v: (Int(randomX002), Int(randomY002))) {
            randomX002 = CGFloat(arc4random_uniform(28))
            randomY002 = CGFloat(arc4random_uniform(49))
        }
        scene.scoreP002 = CGPoint(x: randomX002, y: randomY002)
    }
    
    private func ourNewPoint003() {
        var randomX003 = CGFloat(arc4random_uniform(28))
        var randomY003 = CGFloat(arc4random_uniform(49))
        while contains(a: scene.playerPositions, v: (Int(randomX003), Int(randomY003))) {
            randomX003 = CGFloat(arc4random_uniform(28))
            randomY003 = CGFloat(arc4random_uniform(49))
        }
        scene.scoreP003 = CGPoint(x: randomX003, y: randomY003)
    }
    
    private func didItDie() {
     if scene.playerPositions.count > 0 {
     var thePositions = scene.playerPositions
     let theHead = thePositions[0]
        for (node, x, y) in scene.gameArray {
            if contains(a: [theHead], v: (x,y)) {
                node.fillColor = SKColor.orange
            }
        }
        thePositions.remove(at: 0)
     if contains(a: thePositions, v: theHead) {
     playerDirection = 5
        }
        }
    }
    
    private func theNewPlace() {
        
        var xChange = -1
        var yChange = 0
        
        switch playerDirection {
        case 1:
            //left
            xChange = -1
            yChange = 0
            break
        case 2:
            //up
            xChange = 0
            yChange = -1
            break
        case 3:
            //right
            xChange = 1
            yChange = 0
            break
        case 4:
            //down
            xChange = 0
            yChange = 1
            break
        case 5:
            //end
            xChange = 0
            yChange = 0
            break
        default:
            break
        }
        
        if scene.playerPositions.count > 0 {
            var start = scene.playerPositions.count - 1
            while start > 0 {
                scene.playerPositions[start] = scene.playerPositions[start - 1]
                start -= 1
            }
            scene.playerPositions[0] = (scene.playerPositions[0].0 + yChange, scene.playerPositions[0].1 + xChange)
        }
        
        if scene.playerPositions.count > 0 {
            let x = scene.playerPositions[0].1
            let y = scene.playerPositions[0].0
            if y > 49 {
                scene.playerPositions[0].0 = 0
            } else if y < 0 {
                scene.playerPositions[0].0 = 49
            } else  if x > 28 {
                scene.playerPositions[0].1 = 0
            } else if x < 0 {
                scene.playerPositions[0].1 = 28
            }
        }
        
        doChange()
    }
    
    func doChange() {
        for (node, x, y) in scene.gameArray {
            if contains(a: scene.playerPositions, v: (x,y)) {
                node.fillColor = SKColor.gray
            } else {
                node.fillColor = SKColor.clear
                
                if scene.scoreP1 != nil {
                    if Int((scene.scoreP1?.x)!) == y && Int((scene.scoreP1?.y)!) == x {
                        node.fillColor = SKColor.green
                    }
                }
                
                if scene.scoreP2 != nil {
                    if Int((scene.scoreP2?.x)!) == y && Int((scene.scoreP2?.y)!) == x {
                        node.fillColor = SKColor.black
                    }
                }
                
                if scene.scoreP3 != nil {
                    if Int((scene.scoreP3?.x)!) == y && Int((scene.scoreP3?.y)!) == x {
                        node.fillColor = SKColor.black
                    }
                }
                
                if scene.scoreP4 != nil {
                    if Int((scene.scoreP4?.x)!) == y && Int((scene.scoreP4?.y)!) == x {
                        node.fillColor = SKColor.black
                    }
                }
                
                if scene.scoreP5 != nil {
                    if Int((scene.scoreP5?.x)!) == y && Int((scene.scoreP5?.y)!) == x {
                        node.fillColor = SKColor.green
                    }
                }
                
                if scene.scoreP6 != nil {
                    if Int((scene.scoreP6?.x)!) == y && Int((scene.scoreP6?.y)!) == x {
                        node.fillColor = SKColor.red
                    }
                }
                
                if scene.scoreP7 != nil {
                    if Int((scene.scoreP7?.x)!) == y && Int((scene.scoreP7?.y)!) == x {
                        node.fillColor = SKColor.red
                    }
                }
                
                if scene.scoreP8 != nil {
                    if Int((scene.scoreP8?.x)!) == y && Int((scene.scoreP8?.y)!) == x {
                        node.fillColor = SKColor.red
                    }
                }
                
                if scene.scoreP9 != nil {
                    if Int((scene.scoreP9?.x)!) == y && Int((scene.scoreP9?.y)!) == x {
                        node.fillColor = SKColor.red
                    }
                }
                
                if scene.scoreP0 != nil {
                    if Int((scene.scoreP0?.x)!) == y && Int((scene.scoreP0?.y)!) == x {
                        node.fillColor = SKColor.black
                    }
                }
                
                if scene.scoreP01 != nil {
                    if Int((scene.scoreP01?.x)!) == y && Int((scene.scoreP01?.y)!) == x {
                        node.fillColor = SKColor.green
                    }
                }
                
                if scene.scoreP02 != nil {
                    if Int((scene.scoreP02?.x)!) == y && Int((scene.scoreP02?.y)!) == x {
                        node.fillColor = SKColor.red
                    }
                }
                
                if scene.scoreP03 != nil {
                    if Int((scene.scoreP03?.x)!) == y && Int((scene.scoreP03?.y)!) == x {
                        node.fillColor = SKColor.red
                    }
                }
                
                if scene.scoreP04 != nil {
                    if Int((scene.scoreP04?.x)!) == y && Int((scene.scoreP04?.y)!) == x {
                        node.fillColor = SKColor.red
                    }
                }
                
                if scene.scoreP05 != nil {
                    if Int((scene.scoreP05?.x)!) == y && Int((scene.scoreP05?.y)!) == x {
                        node.fillColor = SKColor.red
                    }
                }
                
                if scene.scoreP06 != nil {
                    if Int((scene.scoreP06?.x)!) == y && Int((scene.scoreP06?.y)!) == x {
                        node.fillColor = SKColor.red
                    }
                }
                
                if scene.scoreP07 != nil {
                    if Int((scene.scoreP07?.x)!) == y && Int((scene.scoreP07?.y)!) == x {
                        node.fillColor = SKColor.red
                    }
                }
                
                if scene.scoreP08 != nil {
                    if Int((scene.scoreP08?.x)!) == y && Int((scene.scoreP08?.y)!) == x {
                        node.fillColor = SKColor.red
                    }
                }
                
                if scene.scoreP09 != nil {
                    if Int((scene.scoreP09?.x)!) == y && Int((scene.scoreP09?.y)!) == x {
                        node.fillColor = SKColor.red
                    }
                }
                
                if scene.scoreP00 != nil {
                    if Int((scene.scoreP00?.x)!) == y && Int((scene.scoreP00?.y)!) == x {
                        node.fillColor = SKColor.black
                    }
                }
                
                if scene.scoreP001 != nil {
                    if Int((scene.scoreP001?.x)!) == y && Int((scene.scoreP001?.y)!) == x {
                        node.fillColor = SKColor.red
                    }
                }
                
                if scene.scoreP002 != nil {
                    if Int((scene.scoreP002?.x)!) == y && Int((scene.scoreP002?.y)!) == x {
                        node.fillColor = SKColor.green
                    }
                }
                
                if scene.scoreP003 != nil {
                    if Int((scene.scoreP003?.x)!) == y && Int((scene.scoreP003?.y)!) == x {
                        node.fillColor = SKColor.red
                    }
                }
            }
        }
    }
    
    func contains(a:[(Int, Int)], v:(Int,Int)) -> Bool {
        let (c1, c2) = v
        for (v1, v2) in a {
            if v1 == c1 && v2 == c2 {
            return true
            }
        }
        return false
    }
    
    func update(time: Double) {
        if nextTime == nil {
            nextTime = time + timePlus
        } else {
            if time >= nextTime! {
                nextTime = time + timePlus
                theNewPlace()
                checkScores()
                didItDie()
                endGame()
            }
        }
    }
}
