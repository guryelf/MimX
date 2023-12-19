//
//  VideoCacheManager.swift
//  MimX
//
//  Created by Furkan Güryel on 12.11.2023.
//

import Foundation
import AVKit
import Cache

class VideoCacheManager{
    
    static let shared = VideoCacheManager()
    private init(){}
    
    let mConfig = MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10)
    let dConfig = DiskConfig(name: "VideoCache")
    lazy var videoStorage: Cache.Storage<String,Data>? = {
        return try? Cache.Storage(diskConfig: dConfig, memoryConfig: mConfig, transformer: TransformerFactory.forData())
      }()
    
    func returnPlayerItem(_ forKey: String) -> CachingPlayerItem{
        var playerItem = CachingPlayerItem(url: URL(string: forKey)!)
        videoStorage?.async.object(forKey: forKey, completion: { result in
            switch result {
            case .value(let data):
                playerItem = CachingPlayerItem(data: data, mimeType: "video/mp4", fileExtension: "mp4")
                print("cached video using")
            case .error(let error):
                playerItem = CachingPlayerItem(url: URL(string: forKey)!)
                print("not cached ")
                print(error.localizedDescription)
            }
        })
        return playerItem
    }
    func isCached(forKey : String) -> Bool{
        var isCached = false
        videoStorage?.async.object(forKey: forKey, completion: { result in
            switch result {
            case .value(_):
                isCached = true
            case .error(let error):
                print(error.localizedDescription)
            }
        })
        return isCached
    }

}

