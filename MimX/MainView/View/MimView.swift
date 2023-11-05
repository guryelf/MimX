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
    var body: some View {
        KFImage(URL(string: video.thumbnail))
            .resizable()
            .onTapGesture {
                cM.selectedVideo = video
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
    }
}

//#Preview {
//    MimView(video: Video.mockVideo, player: <#AVPlayer#>)
//}
