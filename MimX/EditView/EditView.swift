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
    @State var player = AVPlayer(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/mimx-ee4d4.appspot.com/o/ssstwitter.com_1697653735844.mp4?alt=media&token=54b821c3-2f1e-46b6-a775-3792185bd70d")!)
    @StateObject var vM = EditViewModel()
    @State var isButton = false
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
        .background(Color(.systemGray5))
    }
}

#Preview {
    EditView(vM: EditViewModel())
}


