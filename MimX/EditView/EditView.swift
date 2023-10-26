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
    @State private var columns = Array(repeating: GridItem(.fixed(100)), count: 3)
    @State private var isToggle = false
    @State private var url = URL(string: "https://firebasestorage.googleapis.com/v0/b/mimx-ee4d4.appspot.com/o/ssstwitter.com_1697653735844.mp4?alt=media&token=54b821c3-2f1e-46b6-a775-3792185bd70d")
    var body: some View {
        VStack{
            VideoPlayer(player: AVPlayer(url: url!))
                .frame(width: UIScreen.main.bounds.width, height: 300)
            LazyVGrid(columns : columns){
                ForEach(ToolEnum.allCases,id: \.self){button in
                    AddButton(content: {
                        Button(action: {
                            isToggle.toggle()
                        }, label: {
                            VStack(spacing:10,content: {
                                Image(systemName: button.image)
                                    .imageScale(.large)
                                Text(button.title)
                            })
                            .frame(width: 100, height: 60)
                        })
                    }, bgColor:  .blue
                              , fgColor: .white)
                    .frame(width:150,height: 150)
                }
            }
        }
        .background(Color(.systemGray5))
    }
}

#Preview {
    EditView()
}
