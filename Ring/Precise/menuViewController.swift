//
//  menuViewController.swift
//  Ring
//
//  Created by Sermet Cagan on 07/11/15.
//  Copyright © 2015 Sermet Cagan. All rights reserved.
//

import UIKit
import GoogleMobileAds
import GameKit

class menuViewController: UIViewController , GKGameCenterControllerDelegate{
    
    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var infoBttn: UIButton!
    
    //////////////////////////////////////////new added/////
    //initiate gamecenter
    func authenticateLocalPlayer(){
        
        var localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(viewController, error) -> Void in
            
            if (viewController != nil) {
                self.presentViewController(viewController!, animated: true, completion: nil)
            }
                
            else {
                print((GKLocalPlayer.localPlayer().authenticated))
            }
        }
    }
    
    func saveHighscore(score:Int)
    {
        //check if user is signed in
        if GKLocalPlayer.localPlayer().authenticated
        {
            
            var scoreReporter = GKScore(leaderboardIdentifier: "ringbestscoreleaderboard") //leaderboard id here
            
            scoreReporter.value = Int64(score) //score variable here (same as above)
            
            var scoreArray: [GKScore] = [scoreReporter]
            
            GKScore.reportScores(scoreArray, withCompletionHandler: {(error : NSError?) -> Void in
                if error != nil
                {
                    print("error")
                }
            })
            
        }
    }
    
    func saveLevelscore(lev:Int)
    {
        //check if user is signed in
        if GKLocalPlayer.localPlayer().authenticated
        {
            
            var scoreReporter = GKScore(leaderboardIdentifier: "ringbestlevelleaderboard") //leaderboard id here
            
            scoreReporter.value = Int64(lev) //score variable here (same as above)
            
            var scoreArray: [GKScore] = [scoreReporter]
            
            GKScore.reportScores(scoreArray, withCompletionHandler: {(error : NSError?) -> Void in
                if error != nil
                {
                    print("error")
                }
            })
            
        }
    }
    
    func showLeader() {
        var vc = self
        var gc = GKGameCenterViewController()
        gc.gameCenterDelegate = self
        vc.presentViewController(gc, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!)
    {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    /////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authenticateLocalPlayer()
        
        self.bannerView.adUnitID = "ca-app-pub-4100503316831285/7550076258"
        self.bannerView.rootViewController = self
        
        var request:GADRequest = GADRequest()
        request.testDevices = [ "abc3470951e00303eeb4ac2aaaca55bb","74936ba26a96abe9fc122e96aea3ced0","kGADSimulatorID" ]

        self.bannerView.loadRequest(request)
        
        infoBttn.frame = CGRect(x: self.view.frame.width/1.1, y: self.view.frame.height/1.05, width: 60, height: 35)
    }
    
    @IBAction func leaderboardButton(sender: AnyObject)
    {
        showLeader()
    }
    
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
