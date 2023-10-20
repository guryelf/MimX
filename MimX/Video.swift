//
//  Video.swift
//  MimX
//
//  Created by Furkan Güryel on 20.10.2023.
//

import Foundation
import SwiftData
import AVKit


final class Video : Identifiable{
    
    internal init(id: String, tags: [String], video: AVPlayer) {
        self.id = id
        self.tags = tags
        self.video = video
    }
    
    var id: String
    var tags : [String]
    var video : AVPlayer
}
