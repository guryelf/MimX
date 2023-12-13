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
    private var videoAsset : AVAsset?
    private var audioAsset : AVAsset?
    var video: Video
    @Published var player : AVPlayer?
    @Published var audioPlayer : AVAudioPlayerNode?
    @Published var isPlaying : Bool = false
    @Published var rate : Float = 1.0
    @Published var pitch : Float = 0.0
    let engine = AVAudioEngine()
    let speedControl = AVAudioUnitVarispeed()
    let pitchControl = AVAudioUnitTimePitch()
   
    init(video:Video) {
        self.video = video
        self.player = AVPlayer(url: URL(string:video.videoURL)!)
    }
    func getVideoPlayer(url : String){
        let asset = AVAsset(url: URL(string: url)!)
        let composition = AVMutableComposition()
        do{
            let videoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
            try videoTrack?.insertTimeRange(CMTimeRange(start: .zero, duration: asset.duration), of: asset.tracks(withMediaType: .video)[0], at: .zero)
        }catch{
            print(error.localizedDescription)
        }
        let playerItem = AVPlayerItem(asset: composition)
        self.videoAsset = playerItem.asset
        self.player = AVPlayer(playerItem: playerItem)
    }
    
    func getAudioPlayer(url: String) throws{
        let asset = AVAsset(url: URL(string: url)!)
        self.audioAsset = asset
        let audioFile = try AVAudioFile(forReading: URL(string: url)!)
        let audioPlayer = AVAudioPlayerNode()
        engine.attach(audioPlayer)
        engine.attach(pitchControl)
        engine.attach(speedControl)
        engine.connect(audioPlayer, to: speedControl, format: nil)
        engine.connect(speedControl, to: pitchControl, format: nil)
        engine.connect(pitchControl, to: engine.mainMixerNode, format: nil)
        audioPlayer.scheduleFile(audioFile, at: nil)
        
        try? engine.start()
        self.audioPlayer = audioPlayer
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
