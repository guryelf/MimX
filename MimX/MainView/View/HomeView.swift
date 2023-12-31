//
//  HomeView.swift
//  MimX
//
//  Created by Furkan Güryel on 21.10.2023.
//
import Kingfisher
import SwiftUI
import AVKit
import SDWebImageSwiftUI

struct HomeView: View {
    @State private var columns = Array(repeating: GridItem(.fixed(125)), count: 3)
    @StateObject var mVM = MainViewModel()
    @EnvironmentObject var vM : ContentViewModel
    var body: some View {
        ZStack{
            if mVM.videos.isEmpty{
                AnimatedImage(name: "Loading.gif", isAnimating: .constant(true))
                    .resizable()
                    .frame(width: 150, height: 150)
            }
            LazyVGrid(columns: columns,spacing: 10, content: {
                ForEach(mVM.videos){video in
                    if vM.selectedVideo == video{
                        MimVideoView(video: video)
                            .overlay(alignment:.bottom,content: {
                                MimOverlayView(video: video)
                            })
                    }else{
                        MimView(video: video)
                            .overlay(alignment:.bottom,content: {
                                MimOverlayView(video: video)
                            })
                            .frame(width: 125,height: 125)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                }
            })
        }
        /*
        .onReceive(mVM.$videos) { video in
            DispatchQueue.global(qos: .background).async {
                mVM.cacheVideos(videos: video)
            }
        }
         */
    }
}

#Preview {
    HomeView()
        .environmentObject(ContentViewModel())
}

