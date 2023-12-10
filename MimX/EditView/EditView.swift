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
    private var video : Video
    @StateObject private var vM : EditViewViewModel
    @StateObject private var eVM : EditViewModel
    @StateObject private var aM = AudioEngineManager()
    init(video:Video) {
        self.video = video
        self._vM = StateObject(wrappedValue: EditViewViewModel(video: video))
        self._eVM = StateObject(wrappedValue: EditViewModel(video: video))
    }
    var body: some View {
        NavigationStack{
            VStack(spacing:20){
                PlayerView(player: vM.player)
                    .onChange(of: vM.rate, perform: { newValue in
                        vM.player?.rate = vM.rate
                        vM.isPlaying = true
                    })
                    .onChange(of: vM.pitch, perform: { _ in
                        aM.setPitchValue(vM.pitch)
                        aM.startEngine()
                    })
                //pitch implement
                    .onAppear(perform: {
                        aM.startEngine()
                        vM.player?.pause()
                    })
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3)
                HStack(spacing: 0, content: {
                    Button(action: {
                        withAnimation {
                            if vM.isPlaying{
                                vM.player?.pause()
                                vM.isPlaying = false
                            }else{
                                vM.player?.play()
                                vM.player?.rate = vM.rate
                                vM.isPlaying = true
                            }
                        }
                    }, label: {
                        ZStack{
                            Circle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 60, height: 60)
                            Image(systemName: vM.isPlaying ? "pause.fill" : "play.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.blue)
                        }
                    })
                    TimelineSliderView(video:video, images: vM.images)
                })
                
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
        }
    }
}

#Preview {
    EditView(video: Video.mockVideo)
}



