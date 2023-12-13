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
class MainViewModel : ObservableObject{
    
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
    func addToCache(videos : [Video]){
        DispatchQueue.global(qos: .utility).async {
            for video in videos{
                let asset = VideoCacheManager.shared.convertAsset(video: video)
                VideoCacheManager.shared.addToCache(key: video.videoURL, value: asset)
                print("Added to cache")
            }
        }

    }
    
}
