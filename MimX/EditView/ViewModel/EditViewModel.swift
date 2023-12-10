//
//  EditViewModel.swift
//  MimX
//
//  Created by Furkan Güryel on 30.10.2023.
//

import Foundation
import SwiftUI
import AVKit



class EditViewModel : ObservableObject{
    
    var player : AVPlayer
    var rate : Float = 1.0
    
    init(video:Video) {
        self.player = AVPlayer(url: URL(string: video.videoURL)!)
    }
    
    
}

