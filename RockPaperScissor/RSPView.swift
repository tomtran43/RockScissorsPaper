//
//  RockView.swift
//  RockPaperScissor
//
//  Created by Loc Tran on 2/22/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit

class RockView: UIImageView {
    
    var status: Int?
    var speed: Int?
    var widthFrame: Int?
    var heightFrame: Int?
    var widthRSP: Int?
    var heightRSP: Int?
    let RSP = ["rock1.png","scissors1.png","paper1.png"]
    let MOVING: Int = 0
    let CAUGHT: Int = 1
    
    override init(frame: CGRect){
        self.widthRSP = Int(frame.width)
        self.heightRSP = Int(frame.height)
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("intit(coder:) has not been implemented")
    }
    
    
    func genenrateRock(height: Int){
        
        self.heightFrame = height
        let x: Float = Float(arc4random_uniform(375))
        self.status = MOVING
        self.speed = Int(arc4random_uniform(9)) + 2
        let index: Int = Int(arc4random_uniform(3))
        
        if (Int(self.center.y) >= Int(self.heightFrame! - 128 - self.heightRSP!/2)){
            self.image = UIImage(named: RSP[index])
            self.frame = CGRect(x: CGFloat(x), y: -CGFloat(self.widthRSP!), width: CGFloat(self.widthRSP!), height: CGFloat(self.heightRSP!))
        }
    }
    
    func updateMove(){
        
        self.center = CGPoint(x: self.center.x, y: self.center.y + CGFloat(self.speed!))
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
