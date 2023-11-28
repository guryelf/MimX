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
        var imageData = [Data]()
        ImageGenerator.shared.generateImages(url: url) { images in
            imageData = images
        }
        return ImageGenerator.shared.saveImages(url: url, images: imageData)
    }
}
