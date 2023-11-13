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

class AddViewModel : ObservableObject{
    @Published var picker : PhotosPickerItem?{
        didSet {
            Task{
                try? await loadVideo()
            }
        }
    }
    func generateImage(url: URL, second : Int = 1 , compressionQuality: Double = 0.05) -> URL?{
        let imgGenerator = AVAssetImageGenerator(asset: AVAsset(url: url))
        guard let cgImage = try? imgGenerator.copyCGImage(at: .init(seconds: Double(second), preferredTimescale: 1), actualTime: nil) else { return nil}
        let uiImage = UIImage(cgImage: cgImage)
        guard let imageData = uiImage.jpegData(compressionQuality: compressionQuality)
        ,let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return nil }
        let save = path.appendingPathComponent("Thumbnail\(NSUUID()).jpg")
        do {
            try imageData.write(to: save)
        } catch let error {
            print(error.localizedDescription)
        }
        return save
    }
    
    func loadVideo() async throws {
        guard let item = picker else {return  }
        guard let videoData = try await item.loadTransferable(type: Video.self) else {return  }
        let thumbnail = generateImage(url: URL(string: videoData.videoURL)!)
        let video = Video(id: videoData.id, tags: videoData.tags, videoURL: videoData.videoURL, thumbnail: thumbnail?.absoluteString ?? "")
        CRUDManager.shared.createData(selectedVideo: video)
    }
    
}
