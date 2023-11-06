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
    @State var player : AVPlayer
    @State var isPlaying = false
    @EnvironmentObject var cM : ContentViewModel
    init(video:Video) {
        self.video = video
        self.player = AVPlayer(url: URL(string: video.videoURL)!)
    }
    var body: some View {
        VStack{
            PlayerView(player: player)
                .overlay(alignment:.bottom,content: {
                    MimOverlayView()
                })
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
        .frame(width: 125, height: 125)
        .clipShape(RoundedRectangle(cornerRadius: 15))
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
