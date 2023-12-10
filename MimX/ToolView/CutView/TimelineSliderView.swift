//
//  TimelineSliderView.swift
//  MimX
//
//  Created by Furkan Güryel on 14.11.2023.
//

import SwiftUI
import Kingfisher
import AVKit

struct TimelineSliderView: View {
    private var video: Video
    private var images : [URL]
    init(video:Video,images:[URL]){
        self.video = video
        self.images = images
    }
    var body: some View {
        GeometryReader{ proxy in
            Bar(proxy: proxy, video: video, images: images)
                .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
            Thumb(proxy: proxy, imageName: "chevron.left")
                .position(x: proxy.size.width , y: proxy.size.height / 2)
                .gesture(DragGesture()
                         
                )
            Thumb(proxy: proxy, imageName: "chevron.right")
                .position(x: proxy.size.width, y: proxy.size.height / 2)
                .gesture(DragGesture()
                    .onChanged({ value in
                        
                    })
                )
        }
        .frame(width: UIScreen.main.bounds.width, height: 100)
    }
}


fileprivate struct Thumb : View {
    let proxy: GeometryProxy
    let imageName:String
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 15,height: proxy.size.height-20)
            .foregroundStyle(.blue)
            .overlay(alignment: .center) {
                ZStack{
                    Image(systemName: imageName)
                        .foregroundStyle(.white)
                }
            }
    }
}
fileprivate struct Bar : View {
    private let proxy : GeometryProxy
    private var images : [URL]
    private var video: Video
    init(proxy:GeometryProxy,video:Video,images:[URL]){
        self.proxy = proxy
        self.video = video
        self.images = images
    }
    var body: some View {
        Rectangle()
            .frame(width: proxy.size.width, height: proxy.size.height)
            .overlay {
                HStack(spacing:0){
                    ForEach(images,id: \.self) { image in
                        KFImage(image)
                            .resizable()
                            .frame(width: 40,height: proxy.size.height)
                    }
                }
                .frame(width: 40)
            }
    }
}


#Preview {
    TimelineSliderView(video: Video.mockVideo, images: [])
}

