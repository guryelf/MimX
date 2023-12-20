//
//  EditView.swift
//  MimX
//
//  Created by Furkan Güryel on 22.10.2023.
//

import SwiftUI
import AVKit
import AVFoundation

struct EditView: View {
    @State private var selectedTool : ToolEnum?
    @State private var isShowing = false
    @State private var isPlaying = false
    private var video : Video
    @State private var player : AVPlayer
    @State private var audioPlayer : AudioPlayer
    @StateObject private var vM : EditViewViewModel
    @StateObject private var eVM : EditViewModel
    init(video:Video)  {
        self.video = video
        self._vM = StateObject(wrappedValue: EditViewViewModel(video: video))
        self._eVM = StateObject(wrappedValue: EditViewModel(video: video))
        self.player = AVPlayer(playerItem: VideoPlayerManager.shared.cachedPlayer(forKey: video.videoURL))
        self.audioPlayer = AudioPlayer(url: video.audioURL)
    }
    var body: some View {
        NavigationStack{
            PlayerView(player: player)
                .frame(width:UIScreen.main.bounds.width,height: 300)
                .onAppear(perform: {
                    player.volume = 0.0
                    player.pause()
                    audioPlayer.pause()
                })
                .onChange(of: isPlaying, perform: { value in
                    if value{
                        player.play()
                        audioPlayer.play()
                    }else{
                        player.pause()
                        audioPlayer.pause()
                    }
                })
                .onChange(of: vM.pitch, perform: { value in
                    audioPlayer.setPitch(value)
                })
                .onChange(of: vM.rate, perform: { value in
                    player.rate = value
                    
                })
            HStack(spacing: 0) {
                AddButton(content: {
                    Button {
                        self.isPlaying.toggle()
                    } label: {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    .frame(width: 40, height: 40)
                }, bgColor: .blue, fgColor: .white)
                TimelineSliderView(video:video, images: vM.images)
                    .frame(width: UIScreen.main.bounds.width-100, height: 100)
            }
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
                        vM.sheetContent(tool: selectedTool, rate: $vM.rate, pitch: $vM.pitch)
                    }
                }
                .ignoresSafeArea()
                .frame(width:UIScreen.main.bounds.width,height: UIScreen.main.bounds.height/4 + 10)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
            }
        }
        .onDisappear(perform: {
            audioPlayer.stop()
        })
    }
}


#Preview {
    EditView(video: Video.mockVideo)
}



