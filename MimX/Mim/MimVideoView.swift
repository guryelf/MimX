//
//  MimVideoView.swift
//  MimX
//
//  Created by Furkan Güryel on 5.11.2023.
//

import SwiftUI
import AVKit
struct MimVideoView: View {
    let video : Video
    let cachedAsset: AVAsset?
    @State var player : AVPlayer
    @State var isPlaying = false
    @EnvironmentObject var cM : ContentViewModel
    init(video:Video) {
        self.video = video
        self.player = AVPlayer(url: URL(string: video.videoURL)!)
        self.cachedAsset = VideoCacheManager.shared.getFromCache(key: video.id)
    }
    var body: some View {
        VStack{
            if cachedAsset != nil{
                let playeritem = AVPlayerItem(asset: cachedAsset!)
                let cachedPlayer = AVPlayer(playerItem: playeritem)
                PlayerView(player: cachedPlayer)
            }else{
                PlayerView(player: player)
            }
        }
        .frame(width: 125, height: 125)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .onAppear(perform: {
            self.isPlaying.toggle()
        })
        .onTapGesture {
            self.isPlaying.toggle()
        }
        .onChange(of: isPlaying, perform: { value in
            if !cM.isEditActive{
                play(player: player)
            }else if cM.isEditActive{
                cM.editView.toggle()
            }
        })
        .onDisappear(perform: {
            player.pause()
        })
    }
}


extension MimVideoView{
    func play(player : AVPlayer){
        self.isPlaying.toggle()
        if isPlaying {
            player.seek(to: .zero, toleranceBefore: .zero , toleranceAfter: .zero)
            player.play()
        }else if !isPlaying{
            player.pause()
        }
    }
}

#Preview {
    MimVideoView(video: Video.mockVideo)
}
