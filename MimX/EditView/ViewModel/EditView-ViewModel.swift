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
        var imageURLS = [Data]()
        ImageGenerator().generateImages(url: url) { images in
            imageURLS = images
        }
        return ImageGenerator().saveImages(url: url, images: imageURLS)
    }
}
