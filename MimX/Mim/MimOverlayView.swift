//
//  MimOverlayView.swift
//  MimX
//
//  Created by Furkan Güryel on 6.11.2023.
//

import SwiftUI

struct MimOverlayView: View {
    @EnvironmentObject var vM : ContentViewModel
    @State var video: Video
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(height: 30)
            .foregroundStyle(Color(.systemGray6).opacity(0.2))
            .overlay {
                HStack(spacing:30){
                    Button(action: {
                        vM.write(selectedVideo: video)
                    }, label: {
                        Image(systemName: "star.circle.fill")
                            .imageScale(.medium)
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                    })
                    Button(action: {
                        print("share")
                    }, label: {
                        Image(systemName: "square.and.arrow.up.fill")
                            .imageScale(.medium)
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                    })
                    Button(action: {
                        withAnimation {
                            vM.selectedVideo = video
                            vM.editView.toggle()
                        }
                    }, label: {
                        Image(systemName: "pencil.circle.fill")
                            .imageScale(.medium)
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                    })
                }
            }
            
    }
}

#Preview {
    MimOverlayView(video: Video.mockVideo)
}
