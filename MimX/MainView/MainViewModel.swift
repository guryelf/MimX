//
//  MainViewModel.swift
//  MimX
//
//  Created by Furkan Güryel on 22.10.2023.
//

import Firebase
import SwiftUI
import FirebaseFirestoreSwift
import AVKit

@MainActor
class MainViewModel : ObservableObject,CachingPlayerItemDelegate{
    
    @Published var videos = [Video]()
    
    init() {
        Task{
            self.videos = await downloadVideos()
        }
    }
    
    func downloadVideos() async -> [Video]{
        let path = Firestore.firestore().collection("videos")
        guard let videoData = try? await path.getDocuments() else { return []}
        let videos = videoData.documents.compactMap { try? $0.data(as: Video.self) }
        return videos
    }
    
    func cacheVideos(videos:[Video]){
        for video in videos {
            if !VideoCacheManager.shared.isCached(forKey: video.videoURL){
                let playerItem = CachingPlayerItem(url: URL(string: video.videoURL)!)
                playerItem.download()
                playerItem.delegate = self
            }
        }
    }
    nonisolated func playerItem(_ playerItem: CachingPlayerItem, didFinishDownloadingData data: Data) {
        print("cached automatically")
        VideoCacheManager.shared.videoStorage?.async.setObject(data, forKey: playerItem.url.absoluteString, completion: { _ in })
    }
}


