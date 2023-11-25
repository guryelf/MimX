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
    @Binding var player : AVPlayer
    let video : Video
    let startTime : Float = 0
    var endTime : Float
    init(player:Binding<AVPlayer>,video:Video) {
        self._player = player
        self.video = video
        self.endTime = Float(CMTimeGetSeconds(AVAsset(url: URL(string: video.videoURL)!).duration))
    }
    var body: some View {
        GeometryReader{ proxy in
            Text("\(endTime.formatted())")
                .position(x: proxy.size.width,y:proxy.size.height.remainder(dividingBy: proxy.size.height))
            ZStack{
                Bar(proxy: proxy, highlighted: true,endTime: endTime,video: video)
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
    @StateObject var vM = EditViewModel()
    let proxy : GeometryProxy
    var highlighted : Bool
    var highlightedOpacity: Double{
        return highlighted ? 0.3 : 1.0
    }
    init(proxy:GeometryProxy,highlighted:Bool,endTime:Float,video:Video){
        self.proxy = proxy
        self.highlighted = highlighted
        vM.generateImage(url: URL(string: video.videoURL)!, secondRange: 0...Int(endTime.rounded()))
    }
    var body: some View {
        Rectangle()
            .opacity(highlightedOpacity)
            .frame(height: proxy.size.height-20)
            .overlay {
                HStack(spacing:0){
                    ForEach(vM.images,id: \.self) { image in
                        Image(uiImage: UIImage(data: image)!)
                            .resizable()
                            .frame(width: 40,height: proxy.size.height-20)
                    }
                }
            }
        
        
    }
}

#Preview {
    TimelineSliderView(player: .constant(AVPlayer(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/mimx-ee4d4.appspot.com/o/Videos%2Fssstwitter.com_1698952443849.mp4?alt=media&token=bbdf85ed-8ce7-432f-803a-9c0fc18a076f")!)), video: Video.mockVideo)
}

