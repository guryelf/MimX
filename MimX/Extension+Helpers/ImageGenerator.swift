//
//  AVAsset+Extension.swift
//  MimX
//
//  Created by Furkan Güryel on 27.11.2023.
//

import Foundation
import AVFoundation
import SwiftUI

@MainActor
class ImageGenerator{
    
    static let shared = ImageGenerator()
    
    func generateThumbnail(url: URL, second : Int = 1 , compressionQuality: Double = 0.05) -> URL?{
        let imgGenerator = AVAssetImageGenerator(asset: AVURLAsset(url: url))
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
    
    func generateImages(url: URL, compressionQuality: Double = 0.05,completion:@escaping ([Data])->()) {
        let asset = AVAsset(url: url)
        var imageData = [Data]()
        let duration = CMTimeGetSeconds(asset.duration)
        let step = duration/8
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        for second in stride(from: 0, to: duration, by: step){
            print(second)
            do{
                let cgImage = try imgGenerator.copyCGImage(at: .init(seconds: Double(second), preferredTimescale: 1), actualTime: nil)
                let uiImage = UIImage(cgImage: cgImage)
                guard let data = uiImage.jpegData(compressionQuality: compressionQuality) else { return }
                imageData.append(data)
            }catch{
                print(error.localizedDescription)
            }
        }
        completion(imageData)
    }
    func saveImages(url: URL,images: [Data]) -> [URL]{
        let manager = FileManager.default
        return manager.createFolderAndSave(name: url.absoluteString, dataToWrite: images)
    }
}
