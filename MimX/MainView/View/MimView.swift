//
//  MimView.swift
//  MimX
//
//  Created by Furkan Güryel on 4.11.2023.
//

import SwiftUI
import Kingfisher
import AVKit

struct MimView: View {
    var video : Video
    @StateObject var vM = MainViewModel()
    @State var isPlaying = false
    @State var player : AVPlayer
    init(video:Video) {
        self.video = video
        self.player = AVPlayer(url: URL(string: video.videoURL)!)
    }
    var body: some View {
        ZStack{
            KFImage(URL(string: video.thumbnail))
                .resizable()
            if isPlaying{
                PlayerView(player: player)
            }
        }
        .onTapGesture {
            self.isPlaying.toggle()
            if isPlaying{
                player.play()
            }else if !isPlaying{
                player.pause()
            }
        }
    }
}

//#Preview {
//    MimView(video: Video.mockVideo, player: <#AVPlayer#>)
//}
