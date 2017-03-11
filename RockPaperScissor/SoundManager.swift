//
//  Sound.swift
//  RockPaperScissor
//
//  Created by Loc Tran on 3/11/17.
//  Copyright © 2017 LocTran. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class SoundManager {
    
    var _Sound: AVAudioPlayer!
    var url: NSURL?
    
    init(fileName: String){
        url = Bundle.main.url(forResource: fileName, withExtension: "mp3") as NSURL?
    }
    
    func playSong(){
        
        if (url == nil){
            print("Could not find the file \(_Sound)")
        }
        do{
            _Sound = try AVAudioPlayer(contentsOf: url! as URL, fileTypeHint: nil)
        }catch let error as NSError{
            print(error.debugDescription)
        }
        
        if _Sound == nil {
            print("Could not create audio player")
        }
        
        _Sound.prepareToPlay()
//        _Sound.numberOfLoops = -1
        _Sound.play()
        
//        let filePath = Bundle.main.path(forResource: nameSound, ofType: ".mp3")
//        let url = NSURL(fileURLWithPath: filePath!)
//        audioPlayer = try? AVAudioPlayer(contentsOf: url as URL)
//        audioPlayer.prepareToPlay()
//        audioPlayer.play()
    }
}
