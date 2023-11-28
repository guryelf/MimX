//
//  EditView-ViewModel.swift
//  MimX
//
//  Created by Furkan Güryel on 27.11.2023.
//

import Foundation
import AVKit

@MainActor
class EditViewViewModel : ObservableObject{
    @Published var pitch = false
    @Published var speed = false
    @Published var text = false
    
    func generateSliderView(url:URL) -> [URL]?{
        let manager = FileManager.default
        if let urls = manager.isExists(name: url.absoluteString){
            return urls
        }
        var imageData = [Data]()
        ImageGenerator.shared.generateImages(url: url) { images in
            imageData = images
        }
        return ImageGenerator.shared.saveImages(url: url, images: imageData)
    }
}
