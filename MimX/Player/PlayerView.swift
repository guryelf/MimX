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
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.showsPlaybackControls = false
        playerViewController.videoGravity = .resizeAspect
        return playerViewController
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
    }
        
}

extension AVPlayer{
    
    
    static let exampleVideo = AVPlayer(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/mimx-ee4d4.appspot.com/o/ssstwitter.com_1697653735844.mp4?alt=media&token=54b821c3-2f1e-46b6-a775-3792185bd70d")!)
    
}
