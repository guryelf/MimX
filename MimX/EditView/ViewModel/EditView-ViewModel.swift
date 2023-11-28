//
//  EditView-ViewModel.swift
//  MimX
//
//  Created by Furkan Güryel on 27.11.2023.
//

import Foundation
import AVKit

class EditViewViewModel : ObservableObject{
    
    func generateSliderView(url:URL) -> [URL]?{
        let manager = FileManager.default
        if let urls = manager.isExists(name: url.absoluteString){
            return urls
        }else{
            var imageData = [Data]()
            ImageGenerator.shared.generateImages(url: url) { images in
                imageData = images
            }
            return ImageGenerator.shared.saveImages(url: url, images: imageData)
        }
    }
}
