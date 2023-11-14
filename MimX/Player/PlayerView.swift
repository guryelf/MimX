//
//  PlayerView.swift
//  MimX
//
//  Created by Furkan Güryel on 30.10.2023.
//

import SwiftUI
import AVKit

struct PlayerView: UIViewControllerRepresentable {
    
    let player : AVPlayer?
    var rate : Float = 1.0
    
    init(player: AVPlayer?) {
        self.player = player
    }
    
    init(player:AVPlayer?,rate:Float) {
        self.player = player
        self.rate = rate
    }
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.showsPlaybackControls = false
        playerViewController.videoGravity = .resizeAspect
        playerViewController.allowsVideoFrameAnalysis = false
        playerViewController.selectSpeed(AVPlaybackSpeed(rate: rate, localizedName: "Custom"))
        return playerViewController
    }
    

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
    }
    
}


