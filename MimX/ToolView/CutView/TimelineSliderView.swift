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
    @StateObject var vM : EditViewViewModel
    @State private var width : CGFloat = 0
    @State private var width1 : CGFloat = 0
    @State private var playPosition : CGFloat = 50
    @State private var isDragging = false
    var totalWidth = UIScreen.main.bounds.width-100
    init(video:Video) {
        self.video = video
        self._vM = StateObject(wrappedValue: EditViewViewModel(video: video))
    }
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                Bar(video: video, images: vM.generateSliderView(url: URL(string:video.videoURL)!) ?? [])
                    .frame(height: 100)
                HStack(spacing:0){
                    Thumb(imageName: "chevron.left.circle.fill", color: .blue, width: 15)
                        .frame(height: 100)
                        .offset(x: self.width1)
                        .gesture(DragGesture()
                            .onChanged({ value in
                                isDragging = true
                                if value.location.x >= 0 && value.location.x <= self.width - 30 {
                                    self.width1 = value.location.x
                                    self.playPosition = playPosition <= self.width1 ? self.width1 : playPosition
                                }
                            })
                                .onEnded({ _ in
                                    isDragging = false
                                }))
                    Thumb(imageName: "", color: Color(uiColor: .systemGray3), width: 8)
                        .opacity( isDragging ? 0 : 1)
                        .offset(x: self.width1 + playPosition)
                        .gesture(DragGesture()
                            .onChanged({ value in
                                if value.location.x >= 0 && value.location.x >= self.width1 && value.location.x <= self.width {
                                    
                                    self.playPosition = playPosition >= self.width ? playPosition : 0
                                    self.playPosition = playPosition <= self.width1 ? playPosition : 0
                                    self.playPosition = value.location.x
                                }
                            }))
                    Thumb(imageName: "chevron.right.circle.fill",color: .blue,width: 15)
                        .frame(height: 100)
                        .offset(x: self.width - 15)
                        .gesture(DragGesture()
                            .onChanged({ value in
                                isDragging = true
                                if value.location.x <= self.totalWidth && value.location.x >= self.width1 + 30 {
                                    self.width = value.location.x
                                    self.playPosition = playPosition >= self.width ? self.width : playPosition
                                }
                            })
                                .onEnded({ _ in
                                    isDragging = false
                                }))
                }
            }
        }
        .frame(width: totalWidth, height: 100)
        .padding()
    }
}
fileprivate struct Thumb : View {
    let imageName:String
    let color: Color
    let width : CGFloat
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: width)
            .foregroundStyle(color)
            .overlay(alignment: .center) {
                ZStack{
                    Image(systemName: imageName)
                        .foregroundStyle(.white)
                }
            }
    }
}
fileprivate struct Bar : View {
    var images = [URL]()
    var video: Video
    init(video:Video,images: [URL] = []){
        self.video = video
        self.images = images
    }
    var body: some View {
        ZStack(content: {
            Rectangle()
            HStack(spacing:0){
                ForEach(images,id: \.self) { image in
                    KFImage(image)
                        .resizable(capInsets: .init(.zero),resizingMode: .stretch)
                        
                }
            }
            .clipped()
        })
    }
}

#Preview {
    TimelineSliderView(video: Video.mockVideo)
    
}
