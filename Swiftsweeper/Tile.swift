//
//  Tile.swift
//  Swiftsweeper
//
//  Created by Ryan Nowacoski on 12/3/14.
//  Copyright (c) 2014 Ryan Nowacoski. All rights reserved.
//

import Foundation

class Tile {
    //Static properties containing where the tile is
    let row:Int
    let column:Int
    let id:Int
    
    //Variable properties about tiles state
    //These values are defaults and will be reassigned upon the start of a new game
    var numAdjMines = 0
    var isMine = false
    var isRevealed = false
    
    //Standard Initializer
    init(row:Int, column:Int, id:Int) {
        self.row = row
        self.column = column
        self.id = id
    }
}