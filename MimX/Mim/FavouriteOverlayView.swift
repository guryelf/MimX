//
//  FavouriteOverlayView.swift
//  MimX
//
//  Created by Furkan Güryel on 9.11.2023.
//

import SwiftUI

struct FavouriteOverlayView: View {
    @EnvironmentObject var vM : ContentViewModel
    @State var video: Video
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(height: 20)
            .foregroundStyle(Color(.systemGray6).opacity(0.2))
            .overlay {
                HStack(spacing:30){
                    Button(action: {
                        vM.deleteData(selectedVideo: video)
                    }, label: {
                        Image(systemName: "star.slash.fill")
                            .imageScale(.medium)
                            .foregroundStyle(.white)
                            .background(.blue)
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
                }
            }
            .opacity(vM.isEditActive ? 0 : 1)
    }
}

#Preview {
    FavouriteOverlayView(video: Video.mockVideo)
}
