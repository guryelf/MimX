//
//  EditView-ViewModel.swift
//  MimX
//
//  Created by Furkan Güryel on 27.11.2023.
//

import Foundation
import AVKit
import SwiftUI


class EditViewViewModel : ObservableObject{
    
    @MainActor
    var images : [URL]{
        get{
            return generateSliderView(url: URL(string: video.videoURL)!)!
        }
    }
    var asset : AVAsset
    var video: Video
    @Published var player : AVPlayer?
    @Published var isPlaying : Bool = false
    @Published var rate : Float = 1.0
    @Published var pitch : Float = 0.0
    init(video:Video) {
        self.video = video
        self.asset = AVAsset(url: URL(string:video.videoURL)!)
        self.player = AVPlayer(url: URL(string:video.videoURL)!)
    }
    
    
    @MainActor func generateSliderView(url:URL) -> [URL]?{
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
    func sheetContent(tool:ToolEnum,rate: Binding<Float>,pitch:Binding<Float>) -> some View {
        switch tool{
        case .speed:
            SpeedView(rate: rate)
        case .text:
            TextView()
        case .pitch:
            PitchView(pitch:pitch)
        }
    }
    
}
