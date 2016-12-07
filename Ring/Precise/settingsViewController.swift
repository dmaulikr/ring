//
//  settingsViewController.swift
//  Ring
//
//  Created by Sermet Cagan on 13/11/15.
//  Copyright © 2015 Sermet Cagan. All rights reserved.
//

import UIKit
import SpriteKit

class settingsViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource {

    @IBOutlet var ringLabel: UILabel!
    
    @IBAction func menuBttn(sender: AnyObject) {
    }
    @IBOutlet var menuBttn: UIButton!
    
    @IBOutlet var colorPicker: UIPickerView!
    
    @IBOutlet var switchSound: UISwitch!
    
    
    let switchCond = NSUserDefaults.standardUserDefaults()
    let currentColorPicker = NSUserDefaults.standardUserDefaults()
    
    var colorsArray = ["Cyan","Gray","Red","Purple","Orange","Blue","Yellow","Brown","Magenta","Green"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorPicker.dataSource = self
        colorPicker.delegate = self
        
        if let scene = GameScene(fileNamed: "GameScene") {
            //scene.loadTargetColorNo(colorSegment.selectedSegmentIndex)
        }
        
        switchSound.setOn(switchCond.boolForKey("switchCond"), animated: true)
        colorPicker.selectRow(currentColorPicker.integerForKey("currentChoice"), inComponent: 0, animated: true)
        
        switch(currentColorPicker.integerForKey("currentChoice"))
        {
        case 0:
            ringLabel.textColor = UIColor.cyanColor()
        case 1:
            ringLabel.textColor = UIColor.grayColor()
        case 2:
            ringLabel.textColor = UIColor.redColor()
        case 3:
            ringLabel.textColor = UIColor.purpleColor()
        case 4:
            ringLabel.textColor = UIColor.orangeColor()
        case 5:
            ringLabel.textColor = UIColor.blueColor()
        case 6:
            ringLabel.textColor = UIColor.yellowColor()
        case 7:
            ringLabel.textColor = UIColor.brownColor()
        case 8:
            ringLabel.textColor = UIColor.magentaColor()
        case 9:
            ringLabel.textColor = UIColor.greenColor()
        default:
            ringLabel.textColor = UIColor.cyanColor()
            
        }
        menuBttn.frame = CGRect(x: self.view.frame.width/1.1, y: self.view.frame.height/1.05, width: 60, height: 35)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func resetScoreBttn(sender: AnyObject)
    {
        if let scene = GameScene(fileNamed: "GameScene")
        {
            let controllerAlert = UIAlertController(title: "Score Reset", message: "Are You Sure ? ", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(controllerAlert, animated: true, completion: nil)
            let alertAction0 = UIAlertAction(title: "Yes, I'm sure", style: .Default) { (action) -> Void in
                 scene.resetScores()
            }
            let alertAction1 = UIAlertAction(title: "No", style: .Default, handler: nil)
            
            controllerAlert.addAction(alertAction0)
            controllerAlert.addAction(alertAction1)
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colorsArray.count
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: colorsArray[row] , attributes: [NSForegroundColorAttributeName:UIColor.cyanColor()])
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let scene = GameScene(fileNamed: "GameScene")
        {
            if (colorPicker.selectedRowInComponent(0) == 0)
            {
                ringLabel.textColor = UIColor.cyanColor()
                currentColorPicker.setInteger(colorPicker.selectedRowInComponent(0), forKey: "currentChoice")
                scene.loadTargetColorNo(colorPicker.selectedRowInComponent(0))
            }
            else if(colorPicker.selectedRowInComponent(0) == 1)
            {
                ringLabel.textColor = UIColor.grayColor()
                currentColorPicker.setInteger(colorPicker.selectedRowInComponent(0), forKey: "currentChoice")
                scene.loadTargetColorNo(colorPicker.selectedRowInComponent(0))
            }
            else if (colorPicker.selectedRowInComponent(0) == 2)
            {
                ringLabel.textColor = UIColor.redColor()
                currentColorPicker.setInteger(colorPicker.selectedRowInComponent(0), forKey: "currentChoice")
                scene.loadTargetColorNo(colorPicker.selectedRowInComponent(0))
            }
            else if (colorPicker.selectedRowInComponent(0) == 3)
            {
                ringLabel.textColor = UIColor.purpleColor()
                currentColorPicker.setInteger(colorPicker.selectedRowInComponent(0), forKey: "currentChoice")
                scene.loadTargetColorNo(colorPicker.selectedRowInComponent(0))
            }
            else if (colorPicker.selectedRowInComponent(0) == 4)
            {
                ringLabel.textColor = UIColor.orangeColor()
                currentColorPicker.setInteger(colorPicker.selectedRowInComponent(0), forKey: "currentChoice")
                scene.loadTargetColorNo(colorPicker.selectedRowInComponent(0))
            }
            else if (colorPicker.selectedRowInComponent(0) == 5)
            {
                ringLabel.textColor = UIColor.blueColor()
                currentColorPicker.setInteger(colorPicker.selectedRowInComponent(0), forKey: "currentChoice")
                scene.loadTargetColorNo(colorPicker.selectedRowInComponent(0))
            }
            else if (colorPicker.selectedRowInComponent(0) == 6)
            {
                ringLabel.textColor = UIColor.yellowColor()
                currentColorPicker.setInteger(colorPicker.selectedRowInComponent(0), forKey: "currentChoice")
                scene.loadTargetColorNo(colorPicker.selectedRowInComponent(0))
            }
            else if (colorPicker.selectedRowInComponent(0) == 7)
            {
                ringLabel.textColor = UIColor.brownColor()
                currentColorPicker.setInteger(colorPicker.selectedRowInComponent(0), forKey: "currentChoice")
                scene.loadTargetColorNo(colorPicker.selectedRowInComponent(0))
            }
            else if (colorPicker.selectedRowInComponent(0) == 8)
            {
                ringLabel.textColor = UIColor.magentaColor()
                currentColorPicker.setInteger(colorPicker.selectedRowInComponent(0), forKey: "currentChoice")
                scene.loadTargetColorNo(colorPicker.selectedRowInComponent(0))
            }
            else if (colorPicker.selectedRowInComponent(0) == 9)
            {
                ringLabel.textColor = UIColor.greenColor()
                currentColorPicker.setInteger(colorPicker.selectedRowInComponent(0), forKey: "currentChoice")
                scene.loadTargetColorNo(colorPicker.selectedRowInComponent(0))
            }
        }

    }

    @IBAction func switchPressed(sender: AnyObject)
    {
        if let scene = GameScene(fileNamed: "GameScene")
        {
            if (switchSound.on)
            {
                switchCond.setBool(true, forKey: "switchCond")
                scene.soundIsOn(0)
                print("ON")
            }
            if (!switchSound.on)
            {
                switchCond.setBool(false, forKey: "switchCond")
                scene.soundIsOn(1)
                print("OFF")
            }
        }
    }
}
