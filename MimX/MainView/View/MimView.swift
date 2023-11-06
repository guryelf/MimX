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
        VStack{
            KFImage(URL(string: video.thumbnail))
                .resizable()
                .overlay(alignment: .bottom) {
                    MimOverlayView()
                }
                .onTapGesture {
                    cM.selectedVideo = video
                }
        }
    }
}

//#Preview {
//    MimView(video: Video.mockVideo, player: <#AVPlayer#>)
//}