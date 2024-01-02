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
    
    let mConfig = MemoryConfig(expiry: .never, countLimit: 50 , totalCostLimit: 5000)
    let dConfig = DiskConfig(name: "VideoCache",expiry:.seconds(1200))
    lazy var videoStorage: Cache.Storage<String,Data>? = {
        return try? Cache.Storage(diskConfig: dConfig, memoryConfig: mConfig, transformer: TransformerFactory.forData())
    }()
    
    func returnPlayerItem(_ forKey: String,completion: @escaping (CachingPlayerItem) -> ()) {
        do{
            let data = try videoStorage?.object(forKey: forKey)
            let playerItem = CachingPlayerItem(data: data!, mimeType: "video/mp4", fileExtension: "mp4")
            completion(playerItem)
        }catch{
            print(error.localizedDescription)
            let playerItem = CachingPlayerItem(url: URL(string: forKey)!)
            playerItem.delegate = VideoPlayerManager.shared
            completion(playerItem)
        }
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
    func removeExpiredObjects(){
        try? videoStorage?.removeExpiredObjects()
    }
}

