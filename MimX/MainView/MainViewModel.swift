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


class MainViewModel : ObservableObject{
    
    @Published var videos = [Video]()
    
    @MainActor
    init() {
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
    
    func downloadThumbnail(_ thumbnail : String) -> Data{
        var data = Data()
        URLSession.shared.dataTask(with: URL(string: thumbnail)!) { (outputData, _, _) in
            guard let thumbnailData = outputData else { return }
            data = thumbnailData
        }.resume()
        return data
    }
    
    func downloadAudio(audioURL : String,completion: @escaping (URL) -> () ) {
        guard let audioURL = URL(string: audioURL) else {return}
        URLSession.shared.dataTask(with: audioURL) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            let url = TemporaryFileManager.shared.saveDataToTemporaryDirectory(data: data, fileName: "audio\(NSUUID()).m4a")
            completion(url)
        }.resume()
    }
    

}


