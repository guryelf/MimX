//
//  EditView-ViewModel.swift
//  MimX
//
//  Created by Furkan Güryel on 27.11.2023.
//

import Foundation
import AVKit

class EditViewViewModel : ObservableObject{
    @Published var images = [UIImage]()
    @Published var asset : AVAsset?
    
    func returnAsset(video:Video) {
        let asset = AVAsset(url: URL(string: video.videoURL)!)
        self.asset = asset
    }
    
    
    func generateImage(url: URL, compressionQuality: Double = 0.05) {
        let duration = CMTimeGetSeconds(self.asset?.duration ?? CMTime(value: 0, timescale: 0))
        let step = duration/8
        let imgGenerator = AVAssetImageGenerator(asset: self.asset!)
        for second in stride(from: 0, to: duration, by: step){
            print(second)
            do{
                let cgImage = try imgGenerator.copyCGImage(at: .init(seconds: Double(second), preferredTimescale: 1), actualTime: nil)
                let uiImage = UIImage(cgImage: cgImage)
                self.images.append(uiImage)
            }catch{
                print(error.localizedDescription)
            }
        }
        print("images:",self.images.count)
    }
}
