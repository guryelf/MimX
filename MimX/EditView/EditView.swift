//
//  EditView.swift
//  MimX
//
//  Created by Furkan Güryel on 22.10.2023.
//

import SwiftUI
import AVKit

struct EditView: View {
    @State private var selectedTool : ToolEnum?
    @State private var isShowing = false
    @State private var duration : Double
    private var isPlaying = false
    private var video : Video
    private var player : AVPlayer
    @State private var rate : Float = 1.0
    @StateObject private var vM : EditViewViewModel
    init(video:Video) {
        self.video = video
        self.player = AVPlayer(url: URL(string: video.videoURL)!)
        self.duration = AVAsset(url: URL(string: video.videoURL)!).duration.seconds
        self._vM = StateObject(wrappedValue: EditViewViewModel(video: video))
    }
    var body: some View {
        NavigationStack {
            VStack(spacing:20){
                PlayerView(player: player,rate:rate)
                    .frame(width: UIScreen.main.bounds.width, height: 300)
                TimelineSliderView(video:video, range: 0...duration)
                
                HStack(spacing:25){
                    ForEach(ToolEnum.allCases,id: \.self){button in
                        AddButton(content: {
                            Button(action: {
                                withAnimation {
                                    self.selectedTool = button
                                    self.isShowing = true
                                }
                            }, label: {
                                VStack(spacing:10,content: {
                                    Image(systemName: button.image)
                                        .imageScale(.large)
                                    Text(button.title)
                                })
                            })
                            .frame(width: 100, height: 60)
                        }, bgColor:  .blue
                                  , fgColor: .white)
                    }
                }
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            print("sa")
                        }, label: {
                            Image(systemName: "square.and.arrow.up.fill")
                                .resizable()
                                .imageScale(.large)
                        })
                    }
                }
                if isShowing{
                    ToolSheetView(isPresented: $isShowing) {
                        if let selectedTool = selectedTool{
                            vM.sheetContent(tool: selectedTool, speed: $rate)
                        }
                    }
                    .ignoresSafeArea()
                    
                }
            }
            .frame(width: UIScreen.main.bounds.width
                   , height: UIScreen.main.bounds.height)
            .onDisappear(perform: {
                player.pause()
        })
        }
    }
}

#Preview {
    EditView(video: Video.mockVideo)
}



