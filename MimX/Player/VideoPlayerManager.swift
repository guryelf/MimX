//
//  VideoPlayerManager.swift
//  MimX
//
//  Created by Furkan Güryel on 18.12.2023.
//

import Foundation
import AVKit

final class VideoPlayerManager :  CachingPlayerItemDelegate{
    
    static let shared = VideoPlayerManager()
    
    private init(){}
    
    func cachedPlayer(forKey: String) -> CachingPlayerItem{
        var playerItem : CachingPlayerItem? = nil
        VideoCacheManager.shared.returnPlayerItem(forKey) { outputItem,error in
            if outputItem != nil{
                playerItem = outputItem
            }else{
                print(error?.localizedDescription)
                playerItem = CachingPlayerItem(url: URL(string: forKey)!)
                playerItem?.delegate = self
            }
        }
        return playerItem!
    }
    
    func playerItem(_ playerItem: CachingPlayerItem, didFinishDownloadingData data: Data) {
        print("File is downloaded")
        VideoCacheManager.shared.videoStorage?.async.setObject(data, forKey: playerItem.url.absoluteString, completion: { _ in })
    }
    
    
    
    
}

