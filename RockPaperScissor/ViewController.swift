//
//  ViewController.swift
//  RockPaperScissor
//
//  Created by Loc Tran on 2/22/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import UIKit
import AVFoundation

protocol UpdateScore {
    func updateScore(score: Int)
    func endGame(result: String)
}

class ViewController: UIViewController, UpdateScore {
    

    var gameManager: GameManager?
    let timeAdd: [Double] =  [1, 2, 4, 8, 16, 32, 64, 128]
    var indexTimeAdd: Int = 0
    var moveTimer: Timer!
    var addItemTimer: Timer!
    var updateSpeedTimer: Timer!
    var scoreDisplay: Int = 0
    var buttonsendtag: UIButton!
    var soundManager: SoundManager!
  

    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        soundManager = SoundManager(fileName: "gameSoundtrack")
        soundManager.playSong()
        
        addBackGround()
        addScoreZone()
        addStartButton()
        self.gameManager = GameManager()
        self.gameManager?.delegate = self
        addRockButton()
        addPaperButton()
        addScissorsButton()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    internal func endGame(result: String) {
        reset()
    }
    
    internal func updateScore(score: Int) {
        scoreLabel.text = "Score: \(score)"
    }

    func addRSP(){
        
        self.gameManager?.addRSPtoViewController(self, height: Int(self.view.bounds.height), width: Int(self.view.bounds.width))
    }

    func randomTimeAdd(){
        
        indexTimeAdd = Int(arc4random_uniform(UInt32(timeAdd.count)))
    
    }
    
    func addBackGround(){
        
        let background = UIImageView(frame: UIScreen.main.bounds)
        background.image = UIImage(named: "bg.jpg")
        background.contentMode = UIViewContentMode.scaleAspectFill

        self.view.addSubview(background)
        self.view.sendSubview(toBack: background)

    }
    
    func addScoreZone(){
        
        let scoreZone = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(self.view.bounds.height * 5 / 7), width: CGFloat(self.view.bounds.width), height: CGFloat(self.view.bounds.height / 7)))
        
        scoreZone.backgroundColor = UIColor.red
        scoreZone.alpha = 0.6
        
        self.view.addSubview(scoreZone)
        scoreZone.layer.zPosition = CGFloat.greatestFiniteMagnitude
    
    }
    
    func addRockButton(){
        let rockButton = UIButton(frame: CGRect(x: CGFloat(self.view.bounds.width / 10), y: CGFloat(self.view.bounds.height * 13 / 14 - self.view.bounds.width / 10), width: CGFloat(self.view.bounds.width / 5), height: CGFloat(self.view.bounds.width / 5)))
        
        rockButton.setImage(UIImage(named: "rock.png"), for: .normal)
        rockButton.addTarget(self.gameManager, action: #selector(gameManager?.rockButtonClicked), for: .touchUpInside)
        
        self.view.addSubview(rockButton)

    }
    
    func addPaperButton(){
        let paperButton = UIButton(frame: CGRect(x: CGFloat(self.view.bounds.width * 2 / 5), y: CGFloat(self.view.bounds.height * 13 / 14 - self.view.bounds.width / 10), width: CGFloat(self.view.bounds.width / 5), height: CGFloat(self.view.bounds.width / 5)))
        
        paperButton.setImage(UIImage(named: "paper.png"), for: .normal)
        paperButton.addTarget(self.gameManager, action: #selector(gameManager?.paperButtonClicked), for: .touchUpInside)
        
        self.view.addSubview(paperButton)
        
    }
    
    func addScissorsButton(){
        let scissorsButton = UIButton(frame: CGRect(x: CGFloat(self.view.bounds.width * 7 / 10), y: CGFloat(self.view.bounds.height * 13 / 14 - self.view.bounds.width / 10), width: CGFloat(self.view.bounds.width / 5), height: CGFloat(self.view.bounds.width / 5)))
        
        scissorsButton.setImage(UIImage(named: "scissors.png"), for: .normal)
        scissorsButton.addTarget(self.gameManager, action: #selector(gameManager?.scissorsButtonClicked), for: .touchUpInside)
        
        self.view.addSubview(scissorsButton)
        
    }
    
    func addStartButton(){
        let startButton = UIButton(frame: CGRect(x: CGFloat(self.view.bounds.width * 2 / 5), y: CGFloat(self.view.bounds.height / 2 - self.view.bounds.width / 10), width: CGFloat(self.view.bounds.width / 5), height: CGFloat(self.view.bounds.width / 5)))
        
        startButton.setTitle("START", for: .normal)
        startButton.titleLabel?.font = UIFont(name: "System", size: CGFloat(100))
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.addTarget(self, action: #selector(startAction), for: .touchUpInside)
        startButton.layer.cornerRadius = 8.0
        startButton.backgroundColor = UIColor.blue
        startButton.alpha = 0.6
        startButton.tag = 101
        
        self.view.addSubview(startButton)

    }
    
    
    func startAction(sender: UIButton){
        
        buttonsendtag = sender
        if buttonsendtag.tag == 101{
            
            self.gameManager?.addRSPtoViewController(self, height: Int(self.view.bounds.height), width: Int(self.view.bounds.width))
            
            startTimer()
            
            self.gameManager?.startGame()
        
            buttonsendtag.isHidden = true

        }
    }
    
    func startTimer(){
        
        moveTimer = Timer.scheduledTimer(timeInterval: 0.025, target: self.gameManager!, selector: #selector(GameManager.updateMove), userInfo: nil, repeats: true)
        
        addItemTimer = Timer.scheduledTimer(timeInterval: TimeInterval(timeAdd[indexTimeAdd]), target: self, selector: #selector(addRSP), userInfo: nil, repeats: true)
        
        updateSpeedTimer = Timer.scheduledTimer(timeInterval: 5, target: self.gameManager!, selector: #selector(GameManager.updateSpeed), userInfo: nil, repeats: true)
        
    }
    
    
    func reset(){
        moveTimer.invalidate()
        addItemTimer.invalidate()
        updateSpeedTimer.invalidate()
        
        //xoa RSPView
        let subviews = self.view.subviews
        for subview in subviews as [UIView]{
            if subview is RSPView{
                subview.removeFromSuperview()

            }
        }
        
        if buttonsendtag.tag == 101{
            buttonsendtag.isHidden = false
        }
        
    }
    
    
    
}

