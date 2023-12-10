//
//  MimOverlayView.swift
//  MimX
//
//  Created by Furkan Güryel on 6.11.2023.
//

import SwiftUI
import AVKit

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
                        withAnimation(.snappy(duration: 0.25)) {
                            vM.index == 0 ? vM.write(selectedVideo: video) : vM.deleteData(selectedVideo: video)
                        }
                    }, label: {
                        Image(systemName: vM.index == 0 ? "star.circle.fill" : "star.slash.fill")
                            .imageScale(.medium)
                            .foregroundStyle(.white)
                            .background(.blue)
                            .clipShape(Circle())
                    })
                    ShareLink(item: video, preview: SharePreview("MimX-Video", image: Image(video.thumbnail))) {
                        Label(
                            title: { },
                            icon: { Image(systemName: "square.and.arrow.up.fill")
                                .foregroundStyle(.white)}
                        )
                    }
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
