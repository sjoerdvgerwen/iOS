//
//  PlaySound.swift
//  GOceries
//
//  Created by Bram on 17/02/2022.
//

import Foundation
import AVFoundation

var player: AVAudioPlayer!

func playSound(key: String){
    let url = Bundle.main.url(forResource: key, withExtension: "mp3")
    
    guard url != nil else{
        return
    }
    
    do{
        player = try AVAudioPlayer(contentsOf: url!)
        player?.play()
    } catch{
        print(error)
    }
}
