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
    var body: some View {
        ZStack{
            KFImage(URL(string: video.thumbnail))
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 15))
            PlayerView(player: AVPlayer(url: URL(string: video.videoURL)!))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .disabled(self.isPlaying ? false : true)
                .opacity(self.isPlaying ? 1 : 0)
        }
        .onTapGesture {
            self.isPlaying.toggle()
        }
    }
}

#Preview {
    MimView(video: Video.mockVideo)
}
