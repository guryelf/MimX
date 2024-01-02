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
    
    
    private var videoAsset : AVAsset?
    private var audioAsset : AVAsset?
    var video: Video
    @Published var rate : Float = 1.0
    @Published var pitch : Float = 0.0
    @Published var reverb : Float = 0.0
    init(video:Video) {
        self.video = video
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
    func sheetContent(tool:ToolEnum,rate: Binding<Float>,pitch:Binding<Float>,reverb: Binding<Float>,tVM : TextEditorViewModel) -> some View {
        switch tool{
        case .reverb:
            ReverbView(reverb: reverb)
        case .speed:
            SpeedView(rate: rate)
        case .text:
            TextSheetView(vM: tVM)
        case .pitch:
            PitchView(pitch:pitch)
        }
    }
    

    
}
