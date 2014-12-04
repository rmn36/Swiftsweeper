//
//  SettingsViewController.swift
//  Swiftsweeper
//
//  Created by Ryan Nowacoski on 11/26/14.
//  Copyright (c) 2014 Ryan Nowacoski. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    var diff:UInt32 = 10
    var size:Int = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destinationVC = segue.destinationViewController as ViewController
        destinationVC.diff = self.diff
        destinationVC.size = self.size
    }
    
    @IBAction func didChangeDifficulty(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            diff = 10 //easy (default)
        }
        else if sender.selectedSegmentIndex == 1 {
            diff = 6 //medium
        }
        else if sender.selectedSegmentIndex == 0 {
            diff = 3 //hard
        }
        else {
            diff = 1 //literally impossible
        }
    }
}
