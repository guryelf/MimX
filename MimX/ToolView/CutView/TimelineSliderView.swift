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
    var range: ClosedRange<Double>
    @Binding var lowerValue: Double
    @Binding var upperValue: Double
    private var video: Video
    init(video:Video, range: ClosedRange<Double>) {
        self.video = video
        self.range = range
        self._lowerValue = .constant(range.lowerBound)
        self._upperValue = .constant(range.upperBound)
    }
    var body: some View {
        GeometryReader{ proxy in
            Bar(proxy: proxy, video: video)
                .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
            Thumb(proxy: proxy, imageName: "chevron.left")
                .position(x: proxy.size.width * CGFloat((lowerValue - range.lowerBound) / (range.upperBound - range.lowerBound)), y: proxy.size.height / 2)
                .gesture(DragGesture()
                            .onChanged(handleSliderDrag)
                )
            
            Thumb(proxy: proxy, imageName: "chevron.right")
                .position(x: proxy.size.width * CGFloat((upperValue - range.lowerBound) / (range.upperBound - range.lowerBound)), y: proxy.size.height / 2)
                .gesture(DragGesture()
                    .onChanged({ value in
                        handleSliderDrag(value)
                    })
                )
        }
        .frame(width: UIScreen.main.bounds.width-100, height: 100, alignment: .center)
    }
}

extension TimelineSliderView{
    private func handleSliderDrag(_ value: DragGesture.Value) {
        let totalWidth = value.location.x
        let percent = totalWidth / UIScreen.main.bounds.width
        let value = range.lowerBound + Double(percent) * (range.upperBound - range.lowerBound)
        if value >= range.lowerBound && value <= range.upperBound {
            if value >= lowerValue && value <= upperValue {
                lowerValue = value
            } else {
                upperValue = value
            }
        }
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
    var video: Video
    @StateObject var vM : EditViewViewModel
    init(proxy:GeometryProxy,video:Video){
        self.proxy = proxy
        self.video = video
        self._vM = StateObject(wrappedValue: EditViewViewModel(video: video))
        self.images = vM.generateSliderView(url: URL(string: video.videoURL)!)!
        
    }
    var body: some View {
        Rectangle()
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
    TimelineSliderView(video: Video.mockVideo, range: 0...100)
}

