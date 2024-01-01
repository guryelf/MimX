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
    @State private var time : Double = 0
    @State private var selectedTool : ToolEnum?
    @State private var isShowing = false
    @State private var isPlaying = false
    private var video : Video
    var pM = VideoPlayerManager.shared
    @State private var player : AVPlayer
    private var audioPlayer : AudioPlayer
    @StateObject private var vM : EditViewViewModel
    @StateObject private var eVM : EditViewModel
    init(video:Video)  {
        self.video = video
        self._vM = StateObject(wrappedValue: EditViewViewModel(video: video))
        self._eVM = StateObject(wrappedValue: EditViewModel(video: video))
        self.player = AVPlayer(playerItem: pM.cachedPlayer(forKey: video.videoURL))
        self.audioPlayer = AudioPlayer()
    }
    var body: some View {
        NavigationStack{
            PlayerView(player: player)
                .frame(width:UIScreen.main.bounds.width,height: 300)
                .onAppear(perform: {
                    player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: .main) { time in
                        self.time = time.seconds
                        if self.time == player.currentItem!.duration.seconds{
                            isPlaying = false
                        }
                    }
                    player.volume = 0.0
                    player.pause()
                    audioPlayer.stopSound()
                })
                .onChange(of: vM.pitch, perform: { newValue in
                    audioPlayer.updatePitch(newValue)
                })
                .onChange(of: vM.rate, perform: { newValue in
                    player.rate = newValue
                    player.pause()
                    audioPlayer.updateRate(newValue)
                })
                .onChange(of: isPlaying, perform: { value in
                    if value{
                        if self.time == player.currentItem?.duration.seconds{
                            player.seek(to: .zero,toleranceBefore: .zero,toleranceAfter: .zero)
                            player.play()
                            player.rate = vM.rate
                            audioPlayer.playSound(withFileName: video.audioURL, time: 0.0)
                        }else{
                            player.play()
                            player.rate = vM.rate
                            audioPlayer.playSound(withFileName: video.audioURL, time: time)
                        }
                    }else{
                        player.pause()
                        audioPlayer.stopSound()
                    }
                })
            HStack(spacing: 0) {
                AddButton(content: {
                    Button {
                        self.isPlaying.toggle()
                    } label: {
                        Image(systemName: isPlaying  ? "pause.fill" : "play.fill")
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
            player.pause()
            audioPlayer.stopSound()
        })
    }
}


#Preview {
    EditView(video: Video.mockVideo)
}



