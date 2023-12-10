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
    
    
    init(){
        Task{
            self.videos = await downloadVideos()
        }
    }
    @MainActor
    func downloadVideos() async -> [Video]{
        let path = Firestore.firestore().collection("videos")
        guard let videoData = try? await path.getDocuments() else { return []}
        let videos = videoData.documents.compactMap { try? $0.data(as: Video.self) }
        return videos
    }
 
    
}
