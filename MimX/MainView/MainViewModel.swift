//
//  MainViewModel.swift
//  MimX
//
//  Created by Furkan Güryel on 22.10.2023.
//

import Firebase
import SwiftUI
import FirebaseFirestoreSwift

class MainViewModel : ObservableObject{

    @Published var videos = [Video]()
    
    
    init(){
        Task{
            self.videos = await loadVideos()
        }
        
    }
    
    func loadVideos() async -> [Video]{
        let path = Firestore.firestore().collection("videos")
        guard let videoData = try? await path.getDocuments() else { return []}
        let videos = videoData.documents.compactMap { try? $0.data(as: Video.self) }
        return videos
    }
    
}
