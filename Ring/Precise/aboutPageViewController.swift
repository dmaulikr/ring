//
//  aboutPageViewController.swift
//  Ring
//
//  Created by Sermet Cagan on 08/11/15.
//  Copyright © 2015 Sermet Cagan. All rights reserved.
//

import UIKit

class aboutPageViewController: UIViewController {

    @IBAction func backBttn(sender: AnyObject) {
    }
    @IBOutlet var backBttn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBttn.frame = CGRect(x: self.view.frame.width/1.1, y: self.view.frame.height/1.05, width: 60, height: 35)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //connection buttons
    @IBAction func connectTwitterBttn(sender: AnyObject)
    {
        let url0 = NSURL(string: "http://www.twitter.com/official_ring");
        UIApplication.sharedApplication().openURL(url0!)
    }
    @IBAction func connectFacebookBttn(sender: AnyObject)
    {
        let url1 = NSURL(string: "https://www.facebook.com/Ring-925708897513896/?ref=aymt_homepage_panel")
        UIApplication.sharedApplication().openURL(url1!)
    }
    

}
