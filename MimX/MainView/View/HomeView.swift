//
//  HomeView.swift
//  MimX
//
//  Created by Furkan Güryel on 21.10.2023.
//
import Kingfisher
import SwiftUI
import AVKit

struct HomeView: View {
    @State private var columns = Array(repeating: GridItem(), count: 3)
    @StateObject var vM = ContentViewModel()
    @StateObject var mVM = MainViewModel()
    @State var isVideo = false
    var body: some View {
        LazyVGrid(columns: columns,spacing: 10, content: {
            ForEach(mVM.videos){video in
                KFImage(URL(string: video.thumbnail))
                    .resizable()
                    .frame(width: 125, height: 125)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                if isVideo{
                    videoView(videoURL: video.videoURL)
                }
            }
            .onTapGesture {
                isVideo.toggle()
            }
        })
        
    }
}

#Preview {
    HomeView()
}

extension HomeView {
    @ViewBuilder
    func videoView(videoURL : String) -> some View{
        PlayerView(player: AVPlayer(url: URL(string: videoURL)!))
            .frame(width: 125, height: 125)
    }
    
    
    
}
