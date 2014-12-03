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
    let row:Int;
    let column:Int;
    
    //Variable properties about tiles state
    var numAdjMines = 0;
    var isMine = false;
    var isRevealed = false;
    
    //Standard Initializer
    init(row:Int, column:Int) {
        self.row = row;
        self.column = column;
    }
}