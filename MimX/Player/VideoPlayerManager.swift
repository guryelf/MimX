//
//  VideoPlayerManager.swift
//  MimX
//
//  Created by Furkan Güryel on 18.12.2023.
//

import Foundation
import AVKit

class VideoPlayerManager : ObservableObject, CachingPlayerItemDelegate{
    @Published var player : AVPlayer?
    
    init(video:Video) {
        self.player = cachedPlayer(url: URL(string: video.videoURL)!)
    }
    
    func cachedPlayer(url: URL) -> AVPlayer{
        let playerItem = VideoCacheManager.shared.returnPlayerItem(url.absoluteString)
        playerItem.delegate = self
        return AVPlayer(playerItem: playerItem)
    }
    func playerItem(_ playerItem: CachingPlayerItem, didFinishDownloadingData data: Data) {
        print("File is downloaded")
        VideoCacheManager.shared.videoStorage?.async.setObject(data, forKey: playerItem.url.absoluteString, completion: { _ in })
    }
}
