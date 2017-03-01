//
//  GameManager.swift
//  RockPaperScissor
//
//  Created by Loc Tran on 2/22/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit

class GameManager: NSObject {

    var rspViews: NSMutableArray?
    var winResult: String = ""
    var drawResult: String = ""
    var loseResult: String = ""
    var heightFrame: Int?
    var widthFrame: Int?
    var score: Int = 0
    var delegate: UpdateScore!
    var speed = 3
    
    
    override init(){
        self.rspViews = NSMutableArray()
    }
    
    func addRSPtoViewController(_ viewcontroller: UIViewController, height: Int, width: Int){
        
        let rspView = RSPView(frame: CGRect(x: 0, y: 0, width: CGFloat(Double(width) * 0.15), height: CGFloat(Double(width) * 0.15)))
        self.heightFrame = height
        self.widthFrame = width
        rspView.generateRSP(height: height, width: width)
        self.rspViews?.add(rspView)
        viewcontroller.view.addSubview(rspView)

    }
    
    func updateSpeed(){
        
        self.speed = self.speed + 1
    
    }
    
    func updateMove(){
        var currentViews = self.rspViews
        for rspView in self.rspViews!{
            
            if let tmpRSPView = rspView as? RSPView{

                if(currentViews?.contains(tmpRSPView))!{
                    
                    tmpRSPView.speed = self.speed
                    (tmpRSPView as AnyObject).updateMove()
                    
                    if(checkResult(tmpRSPView) == false){
                        
                        resetGame()
                        return
                    }
                }
            }
        }
        
        self.rspViews = currentViews
    }
    
    func resetGame(){
        
        self.rspViews?.removeAllObjects()
        resetResult()
        self.speed = 3
        delegate.updateScore(score: self.score)
    }
    
    func startGame(){
        
        self.score = 0
        delegate.updateScore(score: self.score)
    }
    
    func rockButtonClicked(){
        
        self.drawResult = "rock1.png"
        self.winResult = "scissors1.png"
        self.loseResult = "paper1.png"

    }
    
    func paperButtonClicked(){
        
        self.drawResult = "paper1.png"
        self.winResult = "rock1.png"
        self.loseResult = "scissors1.png"
        
    }

    func scissorsButtonClicked(){
        
        self.drawResult = "scissors1.png"
        self.winResult = "paper1.png"
        self.loseResult = "rock1.png"
            
    }
    
    func resetResult(){
        
        self.winResult = ""
        self.drawResult = ""
        self.loseResult = ""
    
    }
    
    
    func checkResult(_ rspView: RSPView) -> Bool{
        
        if (rspView.status == rspView.inSCOREZONE){
            
            if (rspView.nameRSP == self.winResult){
            
                print("win")
                score = self.score + 1
                delegate.updateScore(score: score)
                self.rspViews?.remove(rspView)
                rspView.removeFromSuperview()
                resetResult()
                
            }else if (rspView.nameRSP == self.drawResult){
                
                print("draw")
                self.rspViews?.remove(rspView)
                rspView.removeFromSuperview()
                resetResult()
                
            }else if (rspView.nameRSP == self.loseResult){
                
                print("lose")
                delegate.endGame(result: "lose")
                return false
            }
            
        }else if (rspView.status == rspView.endSCOREZONE){
            print("lose")
            delegate.endGame(result: "lose")
            resetGame()
            return false
            
        }else{
            
            resetResult()
        }
        
        return true
    }

}
