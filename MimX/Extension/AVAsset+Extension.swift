//
//  AVAsset+Extension.swift
//  MimX
//
//  Created by Furkan Güryel on 27.11.2023.
//

import Foundation
import AVFoundation
import SwiftUI

class ImageGenerator{
    
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
        var direct = FileManager.default.getDocDirect()
        let path = direct.appendingPathComponent(url.absoluteString)
        let fileExists = FileManager.default.fileExists(atPath: path.path)
        if !fileExists{
           try? FileManager.default.createDirectory(atPath: path.path, withIntermediateDirectories: true)
        }
        do{
            let fileURL = path.appendingPathComponent(url.absoluteString)
            try images.compactMap{try $0.write(to: fileURL)}
        }catch{
            print("generateImage function error: ", error)
        }
        let imageURLS = try? FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: .none, options: .skipsHiddenFiles)
        return imageURLS!
    }
}
