//
//  Score.swift
//  Swiftsweeper
//
//  Created by Ryan Nowacoski on 12/4/14.
//  Copyright (c) 2014 Ryan Nowacoski. All rights reserved.
//

import Foundation
import CoreData

class Score: NSManagedObject {

    @NSManaged var difficulty: String
    @NSManaged var moves: NSNumber
    @NSManaged var time: NSNumber

}
