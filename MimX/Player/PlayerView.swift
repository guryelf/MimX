//
//  PlayerView.swift
//  MimX
//
//  Created by Furkan Güryel on 30.10.2023.
//

import SwiftUI
import AVKit

struct PlayerView: UIViewControllerRepresentable {
    
    var player : AVPlayer? = nil
    var videoGravity : AVLayerVideoGravity = .resizeAspect
    
    init(player: AVPlayer?) {
        self.player = player
        setupAudioSession()
    }

    init(player:AVPlayer?,videoGravity: AVLayerVideoGravity) {
        self.player = player
        self.videoGravity = videoGravity
        setupAudioSession()
    }
    
    func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: .mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.showsPlaybackControls = false
        playerViewController.videoGravity = videoGravity
        playerViewController.allowsVideoFrameAnalysis = false
        playerViewController.player?.automaticallyWaitsToMinimizeStalling = false
        return playerViewController
    }
    

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {

    }
    
}


