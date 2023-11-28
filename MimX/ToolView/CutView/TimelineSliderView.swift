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
    init(video:Video) {
        self.video = video
    }
    var body: some View {
        GeometryReader{ proxy in
            ZStack{
                Bar(proxy: proxy, highlighted: true, video: video)
                    .position(x:proxy.size.width/2,y:proxy.size.height/2)
                Thumb(proxy: proxy, imageName: "chevron.left")
                    .position(x:proxy.size.width.remainder(dividingBy: proxy.size.width),y:proxy.size.height/2)
                Thumb(proxy: proxy, imageName: "chevron.right")
                    .position(x:proxy.size.width,y:proxy.size.height/2)
            }
        }
        .frame(width: UIScreen.main.bounds.width-100, height: 100, alignment: .center)
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
    let proxy : GeometryProxy
    var images = [URL]()
    var highlighted : Bool
    var video: Video
    @StateObject var vM = EditViewViewModel()
    var highlightedOpacity: Double{
        return highlighted ? 0.3 : 1.0
    }
    init(proxy:GeometryProxy,highlighted:Bool,video:Video){
        self.proxy = proxy
        self.highlighted = highlighted
        self.video = video
        self.images = vM.generateSliderView(url: URL(string: video.videoURL)!)!
        
    }
    var body: some View {
        Rectangle()
            .opacity(highlightedOpacity)
            .frame(height: proxy.size.height-20)
            .overlay {
                HStack(spacing:0){
                    ForEach(images,id: \.self) { image in
                        KFImage(image)
                            .resizable()
                            .frame(width: 40,height: proxy.size.height-20)
                    }
                }
            }
    }
}

#Preview {
    TimelineSliderView(video: Video.mockVideo)
}

