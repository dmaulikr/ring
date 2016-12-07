//
//  GameViewController.swift
//  Precise
//
//  Created by Sermet Cagan on 04/11/15.
//  Copyright (c) 2015 Sermet Cagan. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    @IBAction func backButton(sender: AnyObject) {
    }
    @IBOutlet var backButton: UIButton!
    
    let extraLife = NSUserDefaults.standardUserDefaults()
    
    func loadExtraLife()
    {
        let extraLife = NSUserDefaults.standardUserDefaults()
        extraLife.setInteger(5, forKey: "my_extra")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
            
            let gameMode = NSUserDefaults.standardUserDefaults()
            
            
            backButton.frame = CGRect(x: self.view.frame.width/1.1, y: self.view.frame.height/1.05, width: 60, height: 35)
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool{
        return true
    }

}
