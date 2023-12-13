//
//  VideoCacheManager.swift
//  MimX
//
//  Created by Furkan Güryel on 12.11.2023.
//

import Foundation
import AVKit

class VideoCacheManager{
    
    static let shared = VideoCacheManager()
    private init(){}
    
    var videoCache : NSCache<NSString, AVAsset> {
        let videoCache = NSCache<NSString, AVAsset>()
        videoCache.countLimit = 300
        videoCache.totalCostLimit = 1024*1024*300 // est. 300mb
        
        return videoCache
    }
    
    func addToCache(key: String, value: AVAsset){
        videoCache.setObject(value, forKey: key as NSString)
    }
    
    func getFromCache(key:String) -> AVAsset?{
        return videoCache.object(forKey: key as NSString)
    }
    
    func convertAsset(video: Video) -> AVAsset{
        let asset = AVAsset(url: URL(string: video.videoURL)!)
        return asset
    }
    
}
