//
//  RockView.swift
//  RockPaperScissor
//
//  Created by Loc Tran on 2/22/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit

class RSPView: UIImageView {
    
    var status: Int?
    var speed: Int = 0
    var widthFrame: Int?
    var heightFrame: Int?
    var widthRSP: Int?
    var heightRSP: Int?
    let RSP = ["rock1.png","scissors1.png","paper1.png"]
    var nameRSP = ""
    let inSCOREZONE: Int = 0
    let beforeSCOREZONE: Int = 1
    let endSCOREZONE: Int = 3

    
    override init(frame: CGRect){
        self.widthRSP = Int(frame.width)
        self.heightRSP = Int(frame.height)
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("intit(coder:) has not been implemented")
    }
    
    func randomRSP(){
        let index: Int = Int(arc4random_uniform(3))
        nameRSP = RSP[index]

    }
    
    func generateRSP(height: Int, width: Int){
        
        self.heightFrame = height
        let x: Float = Float(arc4random_uniform(UInt32(width - Int(Double(width) * 0.15))))
        self.status = beforeSCOREZONE

        randomRSP()
        
        self.image = UIImage(named: nameRSP)
        self.frame = CGRect(x: CGFloat(x), y: -CGFloat(self.heightRSP!), width: CGFloat(self.widthRSP!), height: CGFloat(self.heightRSP!))
            
    }
    
    func updateMove(){
        
        self.center = CGPoint(x: self.center.x, y: self.center.y + CGFloat(self.speed))
        updateStatus()
        if self.status == endSCOREZONE{
            self.removeFromSuperview()
        }
    }

    func updateStatus(){
        let startScoreZone = Int(self.heightFrame! * 5 / 7 + self.heightRSP!/2)
        let endScoreZone = Int(self.heightFrame! * 6 / 7 - self.heightRSP!/2)
        
        if (Int(self.center.y) < startScoreZone){
            self.status = beforeSCOREZONE
        }else if (Int(self.center.y) >= startScoreZone &&
            Int(self.center.y) <= endScoreZone) {
            self.status = inSCOREZONE
        }else {
            self.status = endSCOREZONE
        }
    }

}
