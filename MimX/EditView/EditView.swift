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
    let video : Video
    @State var player : AVPlayer
    @StateObject var vM = EditViewModel()
    @State var isButton = false
    init(video:Video) {
        self.video = video
        self.player = AVPlayer(url: URL(string: video.videoURL)!)
    }
    var body: some View {
        VStack{
            PlayerView(player: player)
                .overlay{
                    vM.playbackButtons(player: player)
                }
                .frame(width: UIScreen.main.bounds.width, height: 300)
            HStack(spacing:25){
                ForEach(ToolEnum.allCases,id: \.self){button in
                    AddButton(content: {
                        Button(action: {
                            isButton.toggle()
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


