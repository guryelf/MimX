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
        self.player = cachedPlayer(forKey: video.videoURL)
    }
    
    func cachedPlayer(forKey: String) -> AVPlayer{
        let playerItem = VideoCacheManager.shared.returnPlayerItem(forKey)
        if VideoCacheManager.shared.isCached(forKey: forKey) == false{
            print("video not cached ")
            playerItem.delegate = self
        }
        return AVPlayer(playerItem: playerItem)
    }
    func playerItem(_ playerItem: CachingPlayerItem, didFinishDownloadingData data: Data) {
        print("File is downloaded")
        VideoCacheManager.shared.videoStorage?.async.setObject(data, forKey: playerItem.url.absoluteString, completion: { _ in })
    }
}
