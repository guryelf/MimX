//
//  EditView.swift
//  MimX
//
//  Created by Furkan Güryel on 22.10.2023.
//

import SwiftUI
import AVKit

struct EditView: View {
    @State var pitch = false
    @State var speed = false
    @State var text = false
    @State var isPlaying = false
    let video : Video
    @State var player : AVPlayer
    @StateObject var vM = EditViewViewModel()
    init(video:Video) {
        self.video = video
        self.player = AVPlayer(url: URL(string: video.videoURL)!)
        vM.returnAsset(video: video)
    }
    var body: some View {
        VStack{
            PlayerView(player: player)
                .frame(width: UIScreen.main.bounds.width, height: 300)
            TimelineSliderView()
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
        .onDisappear(perform: {
            player.pause()
        })
        .background(Color(.systemGray5))
    }
}

#Preview {
    EditView(video: Video.mockVideo)
}



