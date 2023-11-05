//
//  MimVideo.swift
//  MimX
//
//  Created by Furkan Güryel on 5.11.2023.
//

import SwiftUI
import AVKit
struct MimVideo: View {
    let video : Video
    @State var isPlaying = false
    @State var player : AVPlayer
    @StateObject var vM = MainViewModel()
    @StateObject var cM = ContentViewModel()
    init(video:Video) {
        self.video = video
        self.player = AVPlayer(url: URL(string: video.videoURL)!)
    }
    var body: some View {
        PlayerView(player: player)
            .onTapGesture {
                print(cM.isEditActive)
                if !cM.isEditActive{
                    play(player: player)
                }else{
                    cM.editView.toggle()
                }
            }
    }
}

extension MimVideo{
    func play(player : AVPlayer){
        self.isPlaying.toggle()
        cM.selectedVideo = video
        if isPlaying {
            player.seek(to: .zero, toleranceBefore: .zero , toleranceAfter: .zero)
            player.play()
        }else if !isPlaying{
            player.pause()
        }
    }
}
#Preview {
    MimVideo(video: Video.mockVideo)
}
