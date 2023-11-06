//
//  EditViewModel.swift
//  MimX
//
//  Created by Furkan Güryel on 30.10.2023.
//

import Foundation
import SwiftUI
import AVKit



class EditViewModel : ObservableObject{
    
    
    @Published var isPitch = false
    @Published var isSpeed = false
    @Published var isText = false
    @Published var isPlaying = false
    
    
    @ViewBuilder func playbackButtons(player : AVPlayer) -> some View{
        Button(action: {
            self.isPlaying.toggle()
            if self.isPlaying {
                player.play()
            }else if !self.isPlaying{
                player.pause()
            }
        }, label: {
            Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill" )
                .resizable()
                .frame(width: 50, height: 50)
                .background(Circle().fill(.black).opacity(0.5))
        })
    }

}


