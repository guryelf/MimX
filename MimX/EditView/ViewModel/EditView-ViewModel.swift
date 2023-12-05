//
//  EditView-ViewModel.swift
//  MimX
//
//  Created by Furkan Güryel on 27.11.2023.
//

import Foundation
import AVKit
import SwiftUI

@MainActor
class EditViewViewModel : ObservableObject{
    
    var images : [URL]{
        get{
             generateSliderView(url: URL(string: video.videoURL)!)!
        }
    }
    var asset : AVAsset
    var video: Video
    init(video:Video) {
        self.video = video
        self.asset = AVAsset(url: URL(string:video.videoURL)!)
    }
    

    func generateSliderView(url:URL) -> [URL]?{
        let manager = FileManager.default
        var urls = [URL]()
        if let urls = manager.isExists(name: url.absoluteString){
            return urls
        }
        var imageData = [Data]()
        ImageGenerator.shared.generateImages(url: url) { images  in
            imageData = images
        }
        urls = ImageGenerator.shared.saveImages(url: url, images: imageData)
        return urls
    }
    
    @ViewBuilder
    func sheetContent(tool:ToolEnum,rate: Binding<Float>) -> some View {
        switch tool{
         case .speed:
            SpeedView(rate: rate)
         case .text:
             TextView()
         case .pitch:
             PitchView()
         }
     }

}
