//
//  htpViewController.swift
//  Ring
//
//  Created by Sermet Cagan on 07/11/15.
//  Copyright © 2015 Sermet Cagan. All rights reserved.
//

import UIKit
import GoogleMobileAds

class htpViewController: UIViewController{
    
 
    @IBOutlet var bannerView: GADBannerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bannerView.adUnitID = "ca-app-pub-4100503316831285/8887208652"
        self.bannerView.rootViewController = self
        
        var request:GADRequest = GADRequest()
        request.testDevices = [ "abc3470951e00303eeb4ac2aaaca55bb" ,"74936ba26a96abe9fc122e96aea3ced0","kGADSimulatorID"]
        
        self.bannerView.loadRequest(request)

        // Do any additional setup after loading the view.
    }

        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
