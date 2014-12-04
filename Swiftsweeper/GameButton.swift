//
//  GameButton.swift
//  Swiftsweeper
//
//  Created by Ryan Nowacoski on 12/3/14.
//  Copyright (c) 2014 Ryan Nowacoski. All rights reserved.
//

import Foundation
import UIKit

class GameButton: UIButton {
    let tileSize:CGFloat
    var tile:Tile
    
    init(tileModel:Tile, tileSize:CGFloat) {
        self.tile = tileModel
        self.tileSize = tileSize
        
        let x = CGFloat(self.tile.col) * tileSize
        let y = CGFloat(self.tile.row) * tileSize
        let tileFrame = CGRectMake(x, y, tileSize, tileSize)
        
        super.init(frame: tileFrame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getLabelText() -> String {
        // check the isMineLocation and numNeighboringMines properties to determine the text to display
        if !self.tile.isMineLocation {
            if self.tile.numNeighboringMines == 0 {
                // case 1: there's no mine and no neighboring mines
                return ""
            }else {
                // case 2: there's no mine but there are neighboring mines
                return "\(self.tile.numNeighboringMines)"
            }
        }
        // case 3: there's a mine
        return "M"
    }
    
}
