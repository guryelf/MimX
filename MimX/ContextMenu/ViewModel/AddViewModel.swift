//
//  AddView.swift
//  MimX
//
//  Created by Furkan Güryel on 22.10.2023.
//
import Foundation
import SwiftUI
import PhotosUI
import AVKit
import CoreData

// This view model receives the image from the user and converts it to the "Video" struct which conforms to the "Transferable"
// and generates custom thumbnail for the video with "generateImage" function and creates another instance of struct.
// For me it was better if the selected video shows in favourites so I decided to use "CRUDManager" to write to the "FavouriteVideos".
class AddViewModel : ObservableObject{
    
    @Published var picker : PhotosPickerItem?{
        didSet {
            Task{
                try? await loadVideo()
            }
        }
    }
    
    func loadVideo() async throws {
        guard let item = picker else {return  }
        guard let videoData = try await item.loadTransferable(type: Video.self) else {return  }
        let thumbnail = ImageGenerator().generateThumbnail(url: URL(string:videoData.videoURL)!)
        let video = Video(id: videoData.id, tags: videoData.tags, videoURL: videoData.videoURL, thumbnail: thumbnail?.absoluteString ?? "")
        CRUDManager.shared.createData(selectedVideo: video)
    }
    
}
