//
//  GameBoardViewController.swift
//  Swiftsweeper
//
//  Created by Ryan Nowacoski on 12/3/14.
//  Copyright (c) 2014 Ryan Nowacoski. All rights reserved.
//

import UIKit
import CoreData

class GameBoardViewController: UIViewController {

    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var BOARD_SIZE:Int = 10
    var DIFFICULTY:UInt32 = 10
    var board:GameBoard = GameBoard(size:10 , difficulty: 10)
    var gameButtons:[GameButton] = []
    
    var moves:Int = 0 {
        didSet {
            self.movesLabel.text = "Moves: \(moves)"
            self.movesLabel.sizeToFit()
        }
    }
    var timeTaken:Int = 0  {
        didSet {
            self.timeLabel.text = "Time: \(timeTaken)"
            self.timeLabel.sizeToFit()
        }
    }
    var oneSecondTimer:NSTimer?
    
    func oneSecond() {
        self.timeTaken++
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println(DIFFICULTY)
        self.board = GameBoard(size: BOARD_SIZE , difficulty: DIFFICULTY)
        self.initializeBoard()
        self.startNewGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as ViewController
        destinationVC.diff = self.DIFFICULTY
    }
    
    //MARK: Initialize!
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func newGamePressed() {
        println("new game");
        self.endCurrentGame()
        self.startNewGame()
    }
    
    func initializeBoard() {
        for row in 0 ..< board.size {
            for column in 0 ..< board.size {
                let tile = board.tiles[row][column]
                let tileSize:CGFloat = self.boardView.frame.width / CGFloat(BOARD_SIZE)
                let gameButton = GameButton(tileModel: tile, tileSize: tileSize);
                gameButton.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
                gameButton.addTarget(self, action: "squareButtonPressed:", forControlEvents: .TouchUpInside)
                self.boardView.addSubview(gameButton)
                self.gameButtons.append(gameButton)
            }
        }
    }
    
    func resetBoard() {
        // resets the board with new mine locations & sets isRevealed to false for each square
        self.board.resetBoard()
        // iterates through each button and resets the text to the default value
        for tileButton in self.gameButtons {
            tileButton.setTitle("[x]", forState: .Normal)
            tileButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: CGFloat(Float(BOARD_SIZE)/1.5))
            tileButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
            tileButton.setImage(nil, forState: .Normal)
            
        }
    }
    
    func startNewGame() {
        //start new game
        self.resetBoard()
        self.timeTaken = 0
        self.moves = 0
        self.oneSecondTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("oneSecond"), userInfo: nil, repeats: true)
    }
    
    //MARK: Button Actions
    func squareButtonPressed(sender: GameButton) {
        if !sender.tile.isRevealed {
            sender.tile.isRevealed = true
            if sender.getLabelText() == "M" {
                sender.setTitle("", forState: .Normal)
                sender.setImage(UIImage(contentsOfFile: "/Users/ryannowacoski/Downloads/mine.jpg"), forState: .Normal)
            }
            else{
                sender.setTitle("\(sender.getLabelText())", forState: .Normal)
            }
            
            if sender.titleLabel?.text == "1"{
                sender.setTitleColor(UIColor.blueColor(), forState: .Normal)
            }
            else if sender.titleLabel?.text == "2" {
                sender.setTitleColor(UIColor.greenColor(), forState: .Normal)
            }
            else if sender.titleLabel?.text == "3" {
                sender.setTitleColor(UIColor.redColor(), forState: .Normal)
            }
            
            if sender.getLabelText() == "" {
                let adjacentOffsets =
                [(-1,-1),(0,-1),(1,-1), (-1,0),(1,0), (-1,1),(0,1),(1,1)]
            
                for (rowOffset,columnOffset) in adjacentOffsets {
                    // getTileAtLocation might return a Tile, or it might return nil, so use the optional datatype "?"
                    let optionalNeighbor:Tile? = board.getTileAtLocation(sender.tile.row+rowOffset, column: sender.tile.column+columnOffset)
                    // only evaluates true if the optional tile isn't nil
                    if let neighbor = optionalNeighbor {
                        if neighbor.numAdjMines == 0 {
                            neighbor.isRevealed = true
                            for g in gameButtons {
                                if g.tile.id == neighbor.id {
                                    g.setTitle("", forState: .Normal)
                                }
                            }
                        }
                    }
                }
            }

            self.moves++
        }
        
        if sender.tile.isMine {
            self.minePressed()
        }
    }
    
    func minePressed() {
        self.endCurrentGame()
        // show an alert when you tap on a mine
        var alertView = UIAlertView()
        alertView.addButtonWithTitle("New Game")
        alertView.title = "BOOM!"
        alertView.message = "You tapped on a mine."
        alertView.show()
        alertView.delegate = self
    }
    
    
    @IBAction func reveal(sender: AnyObject) {
        for t in gameButtons {
            t.tile.isRevealed = true
            if t.getLabelText() == "M" {
                t.setTitle("", forState: .Normal)
                t.setImage(UIImage(contentsOfFile: "/Users/ryannowacoski/Downloads/mine.jpg"), forState: .Normal)
            }
            else{
                t.setTitle("\(t.getLabelText())", forState: .Normal)
            }
            
            if t.titleLabel?.text == "1"{
                t.setTitleColor(UIColor.blueColor(), forState: .Normal)
            }
            else if t.titleLabel?.text == "2" {
                t.setTitleColor(UIColor.greenColor(), forState: .Normal)
            }
            else if t.titleLabel?.text == "3" {
                t.setTitleColor(UIColor.redColor(), forState: .Normal)
            }
        }
    }
    
    //MARK: Alert and end game
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        //start new game when the alert is dismissed
        self.startNewGame()
    }
    
    func endCurrentGame() {
        self.oneSecondTimer!.invalidate()
        self.oneSecondTimer = nil
    }
    
    
}