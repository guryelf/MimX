//
//  AddView.swift
//  MimX
//
//  Created by Furkan Güryel on 22.10.2023.
//
import Foundation
import SwiftUI
import PhotosUI
import CoreData

class AddViewModel : ObservableObject{
    private let container = FavouriteVideosContainer().persistentContainer
    private var randomName = NSUUID().uuidString
    let direct : URL
    @Published var picker : PhotosPickerItem?{
        didSet {
            Task{
                let data = try? await loadVideo()
                saveVideoToPath(data: data!)
                let directThumbnail = self.saveImageToPath()
                saveVideoToLocal(thumbnailURL: directThumbnail!)
            }
        }
    }
    init(){
        self.direct = FileManager.default.getDocDirect(fileName: "Video\(randomName)")!
    }
    
    func loadVideo() async throws -> Data{
        guard let item = picker else {return Data() }
        guard let videoData = try await item.loadTransferable(type: Data.self) else {return Data() }
        return videoData
    }
    
    func generateImage(url: URL, second : Int = 1 , compressionQuality: Double = 0.05) -> UIImage?{
        let imgGenerator = AVAssetImageGenerator(asset: AVAsset(url: url))
        guard let cgImage = try? imgGenerator.copyCGImage(at: .init(seconds: Double(second), preferredTimescale: 1), actualTime: nil) else { return nil}
        let uiImage = UIImage(cgImage: cgImage)
        guard let imageData = uiImage.jpegData(compressionQuality: compressionQuality), let compressedUIImage = UIImage(data: imageData) else { return nil }
        return compressedUIImage
    }
    
    func saveVideoToPath(data:Data){
        do{
            try data.write(to: self.direct)
            print("Video saved!")
        }catch{
            print("Error occured while 'saving' video " + error.localizedDescription)
        }
    }
    func saveImageToPath() -> URL?{
        let direct = FileManager.default.getDocDirect(fileName: "Thumbnail\(self.randomName)")
        let image = generateImage(url: self.direct)
        let imageData = image?.jpegData(compressionQuality: 0.05)
        do{
            try imageData?.write(to: direct!)
            print("Thumbnail saved!")
        }catch{
            print("Error occured while 'saving' thumbnail " + error.localizedDescription)
        }
        return direct
    }
    func saveVideoToLocal(thumbnailURL:URL){
        let video = Video(id: randomName, tags: "", videoURL: direct.description, thumbnail: thumbnailURL.description)
        CRUDManager.shared.createData(selectedVideo: video)
    }
    
}
