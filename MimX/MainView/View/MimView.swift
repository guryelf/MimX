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
    @EnvironmentObject var cM : ContentViewModel
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
        .overlay(alignment:.topTrailing,content: {
            Button(action: {
                print("favourite")
            }, label: {
                Image(systemName: "star.circle.fill")
                    .imageScale(.large)
                    .foregroundStyle(.white)
                    .clipShape(Circle())
            })
        })
        .onTapGesture {
            cM.selectedVideo = video
            if !cM.isEditActive{
                play(player: player)
            }else{
                cM.editView.toggle()
            }
        }
        .onDisappear(perform: {
            player.pause()
        })
    }
}

extension MimView{

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
//#Preview {
//    MimView(video: Video.mockVideo, player: <#AVPlayer#>)
//}
