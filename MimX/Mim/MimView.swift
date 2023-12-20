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
    init(video:Video) {
        self.video = video
    }
    var body: some View {
        VStack{
            KFImage(URL(string: video.thumbnail))
                .cacheOriginalImage()
                .resizable()
                .overlay(alignment: .bottom) {
                    MimOverlayView(video: video)
                }
                .onTapGesture(count:2) {
                    cM.index == 0 ? cM.write(selectedVideo: video) : cM.deleteData(selectedVideo: video)
                }
                .onTapGesture {
                    cM.selectedVideo = video
                }
        }
        .frame(width: 125, height: 125)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

//#Preview {
//    MimView(video: Video.mockVideo, player: <#AVPlayer#>)
//}
