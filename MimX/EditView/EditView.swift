//
//  EditView.swift
//  MimX
//
//  Created by Furkan Güryel on 22.10.2023.
//

import SwiftUI
import AVKit

struct EditView: View {
    private var pitch = false
    private var speed = false
    private var text = false
    private var isPlaying = false
    private var images = [URL]()
    private var video : Video
    private var player : AVPlayer
    @StateObject var vM = EditViewViewModel()
    init(video:Video) {
        self.video = video
        self.player = AVPlayer(url: URL(string: video.videoURL)!)
        self.images = vM.generateSliderView(url: URL(string: video.videoURL)!)!
    }
    var body: some View {
        VStack{
            PlayerView(player: player)
                .frame(width: UIScreen.main.bounds.width, height: 300)
            TimelineSliderView(video:video,images:images)
            HStack(spacing:25){
                ForEach(ToolEnum.allCases,id: \.self){button in
                    AddButton(content: {
                        Button(action: {
                            
                        }, label: {
                            VStack(spacing:10,content: {
                                Image(systemName: button.image)
                                    .imageScale(.large)
                                Text(button.title)
                            })
                            .frame(width: 100,height: 60)
                        })
                    }, bgColor:  .blue
                              , fgColor: .white)
                }
            }
            .frame(height: 200)
        }
        .onAppear(perform: {
            
        })
        .onDisappear(perform: {
            player.pause()
        })
        .background(Color(.systemGray5))
    }
}

#Preview {
    EditView(video: Video.mockVideo)
}



