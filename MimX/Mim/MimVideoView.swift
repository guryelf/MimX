//
//  MimVideoView.swift
//  MimX
//
//  Created by Furkan Güryel on 5.11.2023.
//

import SwiftUI
import AVKit
import AVFoundation

struct MimVideoView: View{
    let video : Video
    @State var isPlaying = false
    @EnvironmentObject var cM : ContentViewModel
    var vM = VideoPlayerManager.shared
    @State private var player : AVPlayer
    init(video:Video) {
        self.video = video
        self.player = AVPlayer(playerItem: vM.cachedPlayerItem(forKey: video.videoURL))
    }
    var body: some View {
        VStack{
            PlayerView(player: player)
        }
        .frame(width: 125, height: 125)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .onAppear(perform: {
            player.volume = cM.volume
            if !cM.editView{
                isPlaying.toggle()
            }
        })
        .onTapGesture(count: 2, perform: {
            cM.index == 0 ? cM.write(selectedVideo: video) : cM.deleteData(selectedVideo: video)
        })
        .onTapGesture {
            self.isPlaying.toggle()
        }
        .onChange(of: cM.editView, perform: { _ in
            player.pause()
        })
        .onChange(of: isPlaying, perform: { _ in
            if !cM.editView{
                player.volume = cM.volume
                play()
            }
        })
        .onChange(of: cM.volume, perform: { _ in
            player.volume = cM.volume
        })
        .onDisappear(perform: {
            player.pause()
        })
    }
}


extension MimVideoView{
    func play(){
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), queue: nil) { value in
            if value == player.currentItem?.duration{
                player.seek(to: .zero)
                isPlaying = false
            }
        }
        if isPlaying {
            player.seek(to: .zero, toleranceBefore: .zero , toleranceAfter: .zero)
            player.play()
        }else if !isPlaying{
            player.pause()
        }else if isPlaying && player.currentTime() == player.currentItem?.duration{
            player.seek(to: .zero, toleranceBefore: .zero , toleranceAfter: .zero)
            player.play()
        }
    }
}

#Preview {
    MimVideoView(video: Video.mockVideo)
        .environmentObject(ContentViewModel())
}
