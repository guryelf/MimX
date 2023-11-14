//
//  EditViewModel.swift
//  MimX
//
//  Created by Furkan Güryel on 30.10.2023.
//

import Foundation
import SwiftUI
import AVKit



class EditViewModel : ObservableObject{
    @Published var images = [Data]()
    
    
    func generateImage(url: URL, secondRange : ClosedRange<Int> , compressionQuality: Double = 0.05) {
        let imgGenerator = AVAssetImageGenerator(asset: AVAsset(url: url))
        for second in secondRange{
            print(second)
            do{
                let cgImage = try imgGenerator.copyCGImage(at: .init(seconds: Double(second), preferredTimescale: 1), actualTime: nil)
                let uiImage = UIImage(cgImage: cgImage)
                let imageData = uiImage.jpegData(compressionQuality: compressionQuality)
                self.images.append(imageData!)
            }catch{
                print(error.localizedDescription)
            }
            
        }
        print("images:",self.images.count)
    }
    
    
    
}


