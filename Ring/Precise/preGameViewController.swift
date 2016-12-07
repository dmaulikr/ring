//
//  preGameViewController.swift
//  Ring
//
//  Created by Sermet Cagan on 13/11/15.
//  Copyright © 2015 Sermet Cagan. All rights reserved.
//

import UIKit

class preGameViewController: UIViewController {

    @IBAction func menu1Bttn(sender: AnyObject) {
    }
    
    @IBOutlet var menu1Bttn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu1Bttn.frame = CGRect(x: self.view.frame.width/1.1, y: self.view.frame.height/1.05, width: 60, height: 35)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBOutlet var hardcorePlay: UIButton!

    @IBAction func hardcorePlayBttn(sender: AnyObject)
    {
        if let scene = GameScene(fileNamed: "GameScene")
        {
            scene.difficultyUpdate(0)
        }
    }
    @IBOutlet var normalPlay: UIButton!
    
    @IBAction func normalPlayBttn(sender: AnyObject)
    {
        if let scene = GameScene(fileNamed: "GameScene")
        {
            scene.difficultyUpdate(1)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
