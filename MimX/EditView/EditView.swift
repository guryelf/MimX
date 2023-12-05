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
    @State private var isPlaying = false
    @State private var rate : Float = 1.0
    @State private var player : AVPlayer
    private var video : Video
    @StateObject private var vM : EditViewViewModel
    @StateObject private var eVM : EditViewModel
    init(video:Video) {
        self.video = video
        self._vM = StateObject(wrappedValue: EditViewViewModel(video: video))
        self._eVM = StateObject(wrappedValue: EditViewModel(video: video))
        self.player = AVPlayer(url: URL(string: video.videoURL)!)
    }
    var body: some View {
        NavigationStack{
            VStack(spacing:20){
                PlayerView(player: player)
                    .onChange(of: rate, perform: { newValue in
                        player.rate = rate
                        isPlaying = true
                    })
                    .onAppear(perform: {
                        player.pause()
                    })
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3)
                    .overlay(alignment: .center) {
                        Button(action: {
                            withAnimation {
                                if isPlaying{
                                    player.pause()
                                    isPlaying = false
                                }else{
                                    player.play()
                                    player.rate = rate
                                    isPlaying = true
                                }
                            }
                        }, label: {
                            ZStack{
                                Circle()
                                    .fill(Color.gray.opacity(0.5))
                                    .frame(width: 60, height: 60)
                                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.blue)
                            }
                        })
                    }
                TimelineSliderView(video:video, range: 0...vM.asset.duration.seconds)
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
                            vM.sheetContent(tool: selectedTool, rate: $rate)
                        }
                    }
                    .ignoresSafeArea()
                    .frame(width:UIScreen.main.bounds.width,height: UIScreen.main.bounds.height/4 + 10)
                    
                }
            }
            .onDisappear(perform: {
                eVM.player.pause()
            })
        }
    }
}

#Preview {
    EditView(video: Video.mockVideo)
}



