//
//  ViewController.swift
//  Swiftsweeper
//
//  Created by Ryan Nowacoski on 11/26/14.
//  Copyright (c) 2014 Ryan Nowacoski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var diff:UInt32 = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController.isKindOfClass(GameBoardViewController){
            let destinationVC = segue.destinationViewController as GameBoardViewController
            destinationVC.DIFFICULTY = self.diff
        }
        else if segue.destinationViewController.isKindOfClass(SettingsViewController){
            let destinationVC = segue.destinationViewController as SettingsViewController
            destinationVC.diff = self.diff
        }
    }

}

