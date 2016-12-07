//
//  GameScene.swift
//  Precise
//
//  Created by Sermet Cagan on 04/11/15.
//  Copyright (c) 2015 Sermet Cagan. All rights reserved.
//

import SpriteKit
import UIKit
import AVFoundation.AVAudioSession

class GameScene: SKScene
{
    var myscore:Int = 0
    var isOver:Bool = false
    var isSoundOn = true
    
    override func didMoveToView(view: SKView)
    {
        /* Setup your scene here */
        
        let gameMode = NSUserDefaults.standardUserDefaults()
        
        self.backgroundColor = SKColor.blackColor()
        
        if(gameMode.integerForKey("dLevel") == 0)
        {
            let score = loadScore()
            let over = loadGameOverNode()
            let level = loadLevelNode()
            let diff = loadDifficulty()
            let pass = loadPass()

            let levelNode = childNodeWithName("my_level") as! SKLabelNode
            let diffNode = childNodeWithName("my_diff") as! SKLabelNode
            let passNode = childNodeWithName("my_pass") as! SKLabelNode
            let current_score = childNodeWithName("my_score") as! SKLabelNode
            
            let highScore = NSUserDefaults.standardUserDefaults()
            let curLevel = NSUserDefaults.standardUserDefaults()
            let passScore = NSUserDefaults.standardUserDefaults()
            let currScore = NSUserDefaults.standardUserDefaults()

            highScore.integerForKey("highscore")
            let diffLevel = NSUserDefaults.standardUserDefaults().integerForKey("difficulty")
            curLevel.integerForKey("curLevel")
            currScore.integerForKey("currScore")
            passScore.integerForKey("passScore")
            
            current_score.text = "\(curLevel.integerForKey("curLevel") + 1)"
            levelNode.text = "Level: \(curLevel.integerForKey("curLevel") + 1)"
            passNode.text =  "Remaining Rings: \(curLevel.integerForKey("curLevel") + 1)"
            diffNode.text = "Difficulty: \(diffLevel)"
            
            over.alpha = 0
            
            let targets = loadTargetCircle()
            let target = childNodeWithName("my_target") as! SKShapeNode
        }
        else
        {
            let score = loadScore()
            let best = loadBestScoreNode()
            let over = loadGameOverNode()
            let targets = loadTargetCircle()
            let bestScore = childNodeWithName("my_best") as! SKLabelNode
            let target = childNodeWithName("my_target") as! SKShapeNode
            let highScore = NSUserDefaults.standardUserDefaults()
            let current_score = childNodeWithName("my_score") as! SKLabelNode
            
            current_score.text = "0"
            bestScore.text = "Best: \(highScore.integerForKey("highscore"))"
            
            over.alpha = 0
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
       /* Called when a touch begins */
        let gameMode = NSUserDefaults.standardUserDefaults()
        
        if(gameMode.integerForKey("dLevel") == 0)
        {
            let circle = loadCircle()
            circle.fillColor = SKColor.whiteColor()
            circle.setScale(0.1)
            let over = childNodeWithName("my_over") as! SKLabelNode
            
            let curLevel = NSUserDefaults.standardUserDefaults()
            
            var levelDifficulty:Int = curLevel.integerForKey("curLevel")+1
            
            var scaleMode:CGFloat = 1.2
            
            
            //////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////
            /////////////////////////GAME DIFFICULTY//////////////////////////
            //////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////
            switch levelDifficulty
            {
            case 1...5:
                scaleMode = 1.2
            case 5...10:
                scaleMode = 1.24
            case 10...15:
                scaleMode = 1.28
            case 15...20:
                scaleMode = 1.30
            case 20...25:
                scaleMode = 1.34
            default:
                scaleMode = 1.2
            }
            //////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////
            
            over.alpha = 0
            isOver = false
            let growAction = SKAction.scaleBy(scaleMode, duration: 0.1)
            
            circle.runAction(SKAction.repeatActionForever(growAction),withKey: "growAction")
            
            let highScore = NSUserDefaults.standardUserDefaults()
            
            highScore.integerForKey("highscore")
            
        }
        else
        {
            let circle = loadCircle()
            let over = childNodeWithName("my_over") as! SKLabelNode
            let growAction = SKAction.scaleBy(1.2, duration: 0.1)
            let highScore = NSUserDefaults.standardUserDefaults()
            let bestScore = childNodeWithName("my_best") as! SKLabelNode
            
            circle.fillColor = SKColor.whiteColor()
            circle.setScale(0.1)
            
            highScore.integerForKey("highscore")
            
            over.alpha = 0
            isOver = false
            
            circle.runAction(SKAction.repeatActionForever(growAction),withKey: "growAction")
            
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        let gameMode = NSUserDefaults.standardUserDefaults()
        
        if(gameMode.integerForKey("dLevel") == 0)
        {
            let circle = childNodeWithName("my_circle") as! SKShapeNode
            let target = childNodeWithName("my_target") as! SKShapeNode
            circle.removeActionForKey("growAction")
            let stopandRemove = SKAction.sequence([SKAction.waitForDuration(0.5),SKAction.removeFromParent()])
            
            let score = childNodeWithName("my_score") as! SKLabelNode
            
            let levelNode = childNodeWithName("my_level") as! SKLabelNode
            let diffNode = childNodeWithName("my_diff") as! SKLabelNode
            let passNode = childNodeWithName("my_pass") as! SKLabelNode
            
            let over = childNodeWithName("my_over") as! SKLabelNode
            
            let scoreResetAction0 = SKAction.rotateToAngle(CGFloat(M_2_PI), duration: 0.25)
            let scoreResetAction1 = SKAction.rotateToAngle(CGFloat(-M_2_PI), duration: 0.25)
            let scoreResetAction2 = SKAction.rotateToAngle(CGFloat(0), duration: 0.25)
            let scoreBigAction0 = SKAction.scaleTo(2.0, duration: 0.50)
            let scoreBigAction1 = SKAction.scaleTo(1.0, duration: 0.25)
            let scoreBigSequence = SKAction.sequence([scoreBigAction0,scoreBigAction1,scoreResetAction2])
            let scoreResetSequence = SKAction.sequence([scoreResetAction0,scoreResetAction1])
            
            let createDelay = SKAction.waitForDuration(0.5)
            let createAction = SKAction.runBlock({self.loadTargetCircle()})
            let stopandCreate = SKAction.sequence([createDelay,createAction])
            
            let overDelayAction = SKAction.waitForDuration(0.5)
            let overRemoveAction = SKAction.runBlock({over.alpha = 0})
            let overCreateAction = SKAction.runBlock({over.alpha = 1})
            let overSeq = SKAction.sequence([overCreateAction,overDelayAction,overRemoveAction])
            
            let highScore = NSUserDefaults.standardUserDefaults()
            let diffLevel = NSUserDefaults.standardUserDefaults()
            let curLevel = NSUserDefaults.standardUserDefaults()
            let sounds = NSUserDefaults.standardUserDefaults()
            
            
            highScore.integerForKey("highscore")
            diffLevel.integerForKey("difficulty")
            
            
            for touch in touches
            {
                let box:CGRect = CGPathGetBoundingBox(target.path)
                let radi:CGFloat = box.size.width/2.0
                let cirRadi:CGFloat = circle.xScale * 50.0
                
                
                let stopInteraction = SKAction.runBlock({self.view?.userInteractionEnabled = false})
                let delayForInteraction = SKAction.waitForDuration(0.5)
                let contInteraction = SKAction.runBlock({self.view?.userInteractionEnabled = true})
                
                let newLevelAction0 = SKAction.moveByX(10, y: 0, duration: 0.02)
                let newLevelAction1 = SKAction.moveByX(-20, y: 0, duration: 0.04)
                let newLevelAction2 = SKAction.moveByX(20, y: 0, duration: 0.04)
                let newLevelSequence = SKAction.sequence([newLevelAction0,newLevelAction1,newLevelAction2,newLevelAction1,newLevelAction2,newLevelAction1,newLevelAction2,newLevelAction1,newLevelAction2,newLevelAction1,newLevelAction2,newLevelAction1,newLevelAction0])
                
                
                let interactionSequence = SKAction.sequence([stopInteraction,delayForInteraction,contInteraction])
                
                
                if(cirRadi <= radi + target.lineWidth/2 - circle.lineWidth && cirRadi >= radi - target.lineWidth/2 + circle.lineWidth)
                {
                    myscore++
                    
                    passNode.text = "Remaining Rings: \(curLevel.integerForKey("curLevel") + 1 - myscore)"
                    
                    
                    if(sounds.integerForKey("soundDef") == 0)
                    {
                        self.runAction(SKAction.playSoundFileNamed("pop_sfx.mp3", waitForCompletion: false), withKey: "laser")
                    }
                    
                    
                    circle.fillColor = SKColor.cyanColor()
                    circle.strokeColor = SKColor.greenColor()
                    
                    if(myscore == curLevel.integerForKey("curLevel") + 1)
                    {
                        let gvc = menuViewController()
                        gvc.saveLevelscore(curLevel.integerForKey("curLevel")+2)
                        curLevel.setInteger(myscore, forKey: "curLevel")
                        levelNode.text = "Level: \(curLevel.integerForKey("curLevel")+1)"
                        passNode.text = "Remaining Rings: \(curLevel.integerForKey("curLevel")+1)"
                        levelNode.runAction(newLevelSequence)
                        myscore = 0
                    }
                    
                    score.text = "\(curLevel.integerForKey("curLevel") + 1 - myscore)"
                    
                    self.runAction(interactionSequence, withKey: "interactionSeq")
                }
                else
                {
                    myscore = 0;
                    passNode.text = "Remaining Rings: \(curLevel.integerForKey("curLevel") + 1)"
                    passNode.runAction(newLevelSequence)
                    isOver = true
                    
                    self.runAction(interactionSequence, withKey: "interactionSeq")
                    score.runAction(scoreResetSequence, withKey: "scoreReset")
                    score.runAction(scoreBigSequence, withKey: "scoreBig")
                    circle.fillColor = SKColor.redColor()
                    circle.strokeColor = SKColor.redColor()
                    circle.alpha = 0.5
                    score.text = "\(curLevel.integerForKey("curLevel") + 1)"
                }
            
                
                switch curLevel.integerForKey("curLevel")+1
                {
                case 1...5:
                    diffLevel.setInteger(1, forKey: "difficulty")
                    diffNode.text = "Difficulty: \(diffLevel.integerForKey("difficulty"))"
                case 5...10:
                    diffLevel.setInteger(2, forKey: "difficulty")
                    diffNode.text = "Difficulty: \(diffLevel.integerForKey("difficulty"))"
                case 10...15:
                    diffLevel.setInteger(3, forKey: "difficulty")
                    diffNode.text = "Difficulty: \(diffLevel.integerForKey("difficulty"))"
                case 15...20:
                    diffLevel.setInteger(4, forKey: "difficulty")
                    diffNode.text = "Difficulty: \(diffLevel.integerForKey("difficulty"))"
                case 20...100:
                    diffLevel.setInteger(5, forKey: "difficulty")
                    diffNode.text = "Difficulty: \(diffLevel.integerForKey("difficulty"))"
                default:
                    diffLevel.setInteger(1, forKey: "difficulty")
                }
                
                
                if(isOver)
                {
                    self.runAction(overSeq, withKey: "overseq")
                    if(sounds.integerForKey("soundDef") == 0)
                    {
                        self.runAction(SKAction.playSoundFileNamed("laser_sfx0.mp3", waitForCompletion: false))
                    }
                }
            }
            
            circle.runAction(stopandRemove)
            target.runAction(stopandRemove)
            self.runAction(stopandCreate, withKey: "create")
        }
        else
        {
            let circle = childNodeWithName("my_circle") as! SKShapeNode
            let target = childNodeWithName("my_target") as! SKShapeNode
            circle.removeActionForKey("growAction")
            let stopandRemove = SKAction.sequence([SKAction.waitForDuration(0.5),SKAction.removeFromParent()])
            
            let score = childNodeWithName("my_score") as! SKLabelNode
            
            let bestScore = childNodeWithName("my_best") as! SKLabelNode
            
            let over = childNodeWithName("my_over") as! SKLabelNode
            
            let scoreResetAction0 = SKAction.rotateToAngle(CGFloat(M_2_PI), duration: 0.25)
            let scoreResetAction1 = SKAction.rotateToAngle(CGFloat(-M_2_PI), duration: 0.25)
            let scoreResetAction2 = SKAction.rotateToAngle(CGFloat(0), duration: 0.25)
            let scoreBigAction0 = SKAction.scaleTo(2.0, duration: 0.50)
            let scoreBigAction1 = SKAction.scaleTo(1.0, duration: 0.25)
            let scoreBigSequence = SKAction.sequence([scoreBigAction0,scoreBigAction1,scoreResetAction2])
            let scoreResetSequence = SKAction.sequence([scoreResetAction0,scoreResetAction1])
            
            let createDelay = SKAction.waitForDuration(0.5)
            let createAction = SKAction.runBlock({self.loadTargetCircle()})
            let stopandCreate = SKAction.sequence([createDelay,createAction])
            
            let overDelayAction = SKAction.waitForDuration(0.5)
            let overRemoveAction = SKAction.runBlock({over.alpha = 0})
            let overCreateAction = SKAction.runBlock({over.alpha = 1})
            let overSeq = SKAction.sequence([overCreateAction,overDelayAction,overRemoveAction])
            
            let highScore = NSUserDefaults.standardUserDefaults()
            let recoverScore = NSUserDefaults.standardUserDefaults()
            let sounds = NSUserDefaults.standardUserDefaults()
            
            
            highScore.integerForKey("highscore")
            
            for touch in touches
            {
                let box:CGRect = CGPathGetBoundingBox(target.path)
                let radi:CGFloat = box.size.width/2.0
                let cirRadi:CGFloat = circle.xScale * 50.0
                
                let stopInteraction = SKAction.runBlock({self.view?.userInteractionEnabled = false})
                let delayForInteraction = SKAction.waitForDuration(0.5)
                let contInteraction = SKAction.runBlock({self.view?.userInteractionEnabled = true})
                let interactionSequence = SKAction.sequence([stopInteraction,delayForInteraction,contInteraction])
                
                
                if(cirRadi <= radi + target.lineWidth/2 - circle.lineWidth && cirRadi >= radi - target.lineWidth/2 + circle.lineWidth)
                {
                    myscore++
                    
                    if(sounds.integerForKey("soundDef") == 0)
                    {
                        self.runAction(SKAction.playSoundFileNamed("pop_sfx.mp3", waitForCompletion: false), withKey: "laser")
                    }
                    
                    
                    circle.fillColor = SKColor.cyanColor()
                    circle.strokeColor = SKColor.greenColor()
                    
                    if(myscore >= highScore.integerForKey("highscore"))
                    {
                        highScore.setInteger(myscore, forKey: "highscore")
                        var gameVC = menuViewController()
                        gameVC.saveHighscore(highScore.integerForKey("highscore"))
                    }
                    
                    score.text = "\(myscore)"
                    bestScore.text = "Best: \(highScore.integerForKey("highscore"))"
                    
                    self.runAction(interactionSequence, withKey: "interactionSeq")
                }
                else
                {
                    myscore = 0;
                    isOver = true

                    self.runAction(interactionSequence, withKey: "interactionSeq")
                    score.runAction(scoreResetSequence, withKey: "scoreReset")
                    score.runAction(scoreBigSequence, withKey: "scoreBig")
                    circle.fillColor = SKColor.redColor()
                    circle.strokeColor = SKColor.redColor()
                    circle.alpha = 0.5
                    score.text = "\(myscore)"
                }
                
                
                if(isOver)
                {
                    self.runAction(overSeq, withKey: "overseq")
                    if(sounds.integerForKey("soundDef") == 0)
                    {
                        self.runAction(SKAction.playSoundFileNamed("laser_sfx0.mp3", waitForCompletion: false))
                    }
                }
            }
            
            circle.runAction(stopandRemove)
            target.runAction(stopandRemove)
            self.runAction(stopandCreate, withKey: "create")
        }
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////          ////  /////  ///    //////  ////         /////        ///////////  //////////////
    ////////////  ////////////  /////  ///  /  /////  ////  ////////////  /////////////////  //////////////
    ////////////        //////  /////  ///  //  ////  ////  //////////////  ///////////////  //////////////
    ////////////  ////////////  /////  ///  ////  //  ////  ////////////////  /////////////  //////////////
    ////////////  ////////////  /////  ///  ///////   ////  ///////////////////  //////////  //////////////
    ////////////  ////////////         ///  ////////  ////         /////         //////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////  //////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func loadScore()
    {
        let scoreLabel = SKLabelNode()
        var scoreCount:Int = 1
        scoreLabel.text = "\(scoreCount)"
        scoreLabel.fontColor = SKColor.whiteColor()
        scoreLabel.fontSize = 42
        scoreLabel.fontName = "Copperplate Bold"
        scoreLabel.position = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/1.2)
        scoreLabel.name = "my_score"
        
        addChild(scoreLabel)
    }
    
    func loadCircle() -> SKShapeNode
    {
        let circle = SKShapeNode(circleOfRadius: 50.0)
        circle.fillColor = SKColor.whiteColor()
        circle.position = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0)
        circle.name = "my_circle"
        
        addChild(circle)
        
        return circle
    }
    
    func loadTargetCircle() -> SKShapeNode
    {
        let color_index = NSUserDefaults.standardUserDefaults()
        let diff_index = NSUserDefaults.standardUserDefaults()
        
        var radius:CGFloat = CGFloat(rand()%165 + 50)
        let targetCircle = SKShapeNode(circleOfRadius: radius)
        targetCircle.alpha = 0.5
        targetCircle.position = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0)
        
        let bonuses = NSUserDefaults.standardUserDefaults()
        
        switch diff_index.integerForKey("difficulty")
        {
        case 1:
            targetCircle.lineWidth = CGFloat(rand()%20 + Int(20))
        case 2:
            targetCircle.lineWidth = CGFloat(rand()%20 + Int(15))
        case 3:
            targetCircle.lineWidth = CGFloat(rand()%20 + Int(10))
        case 4:
            targetCircle.lineWidth = CGFloat(rand()%15 + Int(10))
        case 5:
            targetCircle.lineWidth = CGFloat(rand()%10 + Int(7))
        default:
            targetCircle.lineWidth = CGFloat(rand()%20 + Int(10))
        }
        
        switch color_index.integerForKey("color_def")
        {
        case 0:
            targetCircle.strokeColor = SKColor.cyanColor()
        case 1:
            targetCircle.strokeColor = SKColor.whiteColor()
        case 2:
            targetCircle.strokeColor = SKColor.redColor()
        case 3:
            targetCircle.strokeColor = SKColor.purpleColor()
        case 4:
            targetCircle.strokeColor = SKColor.orangeColor()
        case 5:
            targetCircle.strokeColor = SKColor.blueColor()
        case 6:
            targetCircle.strokeColor = SKColor.yellowColor()
        case 7:
            targetCircle.strokeColor = SKColor.brownColor()
        case 8:
            targetCircle.strokeColor = SKColor.magentaColor()
        case 9:
            targetCircle.strokeColor = SKColor.greenColor()
        default:
            print("default")

        }
        targetCircle.name = "my_target"
        
        addChild(targetCircle)
        
        return targetCircle
    }
    
    func loadTargetColorNo(c_no : Int) -> AnyObject
    {
        let color_def = NSUserDefaults.standardUserDefaults()
        
        switch c_no
        {
        case 0:
            color_def.setInteger(c_no, forKey: "color_def")
        case 1:
            color_def.setInteger(c_no, forKey: "color_def")
        case 2:
            color_def.setInteger(c_no, forKey: "color_def")
        case 3:
            color_def.setInteger(c_no, forKey: "color_def")
        case 4:
            color_def.setInteger(c_no, forKey: "color_def")
        case 5:
            color_def.setInteger(c_no, forKey: "color_def")
        case 6:
            color_def.setInteger(c_no, forKey: "color_def")
        case 7:
            color_def.setInteger(c_no, forKey: "color_def")
        case 8:
            color_def.setInteger(c_no, forKey: "color_def")
        case 9:
            color_def.setInteger(c_no, forKey: "color_def")
        default:
            print("default")
        }
        

        return  color_def.integerForKey("color_def")
    }
    
    func loadGameOverNode() -> SKLabelNode
    {
        let overNode = SKLabelNode()
        overNode.text = "X"
        overNode.position = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.1)
        overNode.fontColor = SKColor.whiteColor()
        overNode.fontSize = 100
        overNode.fontName = "Copperplate Bold"
        overNode.name = "my_over"

        addChild(overNode)
        
        return overNode
    }
    
    func loadBestScoreNode()
    {
        var bestScore:Int = 0
        let bestNode = SKLabelNode()
        bestNode.text = "Best: \(bestScore)"
        bestNode.fontName = "Copperplate Bold"
        bestNode.fontSize = 25
        bestNode.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/1.05)
        bestNode.fontColor = SKColor.whiteColor()
        bestNode.name = "my_best"
        
        addChild(bestNode)
    }
    
    func loadLevelNode()
    {
        var currentLevel:Int = 1
        let levelNode = SKLabelNode()
        levelNode.text = "Level: \(currentLevel)"
        levelNode.fontName = "Copperplate Bold"
        levelNode.fontSize = 25
        levelNode.fontColor = SKColor.whiteColor()
        levelNode.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/1.05 + levelNode.frame.size.height)
        levelNode.name = "my_level"
        
        addChild(levelNode)
    }
    
    func loadPass()
    {
        var needScore:Int = 1
        let passNode = SKLabelNode()
        passNode.text = "Remaining Rings: \(needScore)"
        passNode.fontName = "Copperplate Bold"
        passNode.fontSize = 25
        passNode.fontColor = SKColor.whiteColor()
        passNode.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/1.05 - passNode.frame.size.height)
        passNode.name = "my_pass"
        
        addChild(passNode)
    }
    
    func loadDifficulty()
    {
        var diffLevel:Int = 1
        let diffNode = SKLabelNode()
        diffNode.text = "Difficulty: \(diffLevel)"
        diffNode.fontName = "Copperplate Bold"
        diffNode.fontColor = SKColor.whiteColor()
        diffNode.fontSize = 25
        diffNode.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/1.05)
        diffNode.name = "my_diff"
        
        addChild(diffNode)
    }
    
    func resetScores()
    {
        let diffLevel = NSUserDefaults.standardUserDefaults()
        let curLevel = NSUserDefaults.standardUserDefaults()
        ///
        let highScore = NSUserDefaults.standardUserDefaults()
        highScore.integerForKey("highscore")
        highScore.setInteger(0, forKey: "highscore")
        ///
        diffLevel.integerForKey("difficulty")
        curLevel.integerForKey("curLevel")
        curLevel.setInteger(0, forKey: "curLevel")
        diffLevel.setInteger(1, forKey: "difficulty")
    }
    
    func soundIsOn(curSound : Int) -> AnyObject
    {
        let soundDefault = NSUserDefaults.standardUserDefaults()
        
        switch curSound
        {
        case 0:
            soundDefault.setInteger(0, forKey: "soundDef")
        case 1:
            soundDefault.setInteger(1, forKey: "soundDef")
        default:
            soundDefault.setInteger(1, forKey: "soundDef")
        }
        
        return soundDefault.integerForKey("soundDef")
    }
    
    func difficultyUpdate(dLevel : Int) -> AnyObject
    {
        let dLevelDef = NSUserDefaults.standardUserDefaults()
        
        switch dLevel
        {
        case 0:
            dLevelDef.setInteger(0, forKey: "dLevel")
        case 1:
            dLevelDef.setInteger(1, forKey: "dLevel")
        default:
            dLevelDef.setInteger(0, forKey: "dLevel")
        }
        return dLevelDef.integerForKey("dLevel")
    }
}
