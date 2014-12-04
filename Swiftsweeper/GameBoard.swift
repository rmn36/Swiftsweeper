//
//  GameBoard.swift
//  Swiftsweeper
//
//  Created by Ryan Nowacoski on 12/3/14.
//  Copyright (c) 2014 Ryan Nowacoski. All rights reserved.
//

import Foundation

class GameBoard {
    // size of the board (size x size)
    let size:Int
    
    //The higher the difficulty the easier the game
    //Number of mines is determined by a 1-out of- difficulty
    let difficulty:UInt32
    
    // a 2d array of tile cells, indexed by [row][column]
    var tiles:[[Tile]] = []
    
    //Initializes the two dimensional array tiles
    init(size:Int, difficulty:UInt32) {
        self.size = size
        self.difficulty = difficulty
        var id:Int = 1
        for row in 0 ..< size {
            var tileRow:[Tile] = []
            for column in 0 ..< size {
                let cell = Tile(row: row, column: column , id: id)
                tileRow.append(cell)
                id++
            }
            tiles.append(tileRow)
        }
    }
    
    //This function resets the game board with a new lay out of mines
    func resetBoard() {
        // assign mines to tiles
        for row in 0 ..< size {
            for column in 0 ..< size {
                tiles[row][column].isRevealed = false
                self.calculateIsMineLocationForTile(tiles[row][column])
            }
        }
        // count number of neighboring tiles
        for row in 0 ..< size {
            for column in 0 ..< size {
            self.calculateNumNeighborMinesForTile(tiles[row][column])
            }
        }
    }

    func calculateIsMineLocationForTile(tile: Tile) {
        tile.isMine = ((arc4random()%difficulty) == 0) // 1-in-difficulty chance that each location contains a mine
    }
    
    func calculateNumNeighborMinesForTile(tile : Tile) {
        // first get a list of adjacent tiles
        let neighbors = getNeighboringTiles(tile)
        var numNeighboringMines = 0
        
        // for each neighbor with a mine, add 1 to this tile's count
        for neighborTile in neighbors {
            if neighborTile.isMine {
                numNeighboringMines++
            }
        }
        tile.numAdjMines = numNeighboringMines
    }
    
    func getNeighboringTiles(tile : Tile) -> [Tile] {
        var neighbors:[Tile] = []
        
        // an array of tuples containing the relative position of each neighbor to the tile
        let adjacentOffsets =
        [(-1,-1),(0,-1),(1,-1), (-1,0),(1,0), (-1,1),(0,1),(1,1)]
        
        for (rowOffset,columnOffset) in adjacentOffsets {
            // getTileAtLocation might return a Tile, or it might return nil, so use the optional datatype "?"
            let optionalNeighbor:Tile? = getTileAtLocation(tile.row+rowOffset, column: tile.column+columnOffset)
            // only evaluates true if the optional tile isn't nil
            if let neighbor = optionalNeighbor {
                neighbors.append(neighbor)
            }
        }
        return neighbors
    }
    
    func getTileAtLocation(row : Int, column : Int) -> Tile? {
        if row >= 0 && row < self.size && column >= 0 && column < self.size {
            return tiles[row][column]
        } else {
            return nil
        }
    }
}