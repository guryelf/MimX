//
//  FavouriteView.swift
//  MimX
//
//  Created by Furkan Güryel on 21.10.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavouriteView: View {
    @State private var columns = Array(repeating: GridItem(.fixed(125)), count: 3)
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var vM : ContentViewModel
    var body: some View {
        LazyVGrid(columns: columns,spacing: 10, content: {
            ForEach(vM.favourites){video in
                if vM.selectedVideo == video{
                    MimVideoView(video: video)
                        .overlay(alignment:.bottom,content: {
                            MimOverlayView(video: video)
                        })
                }else{
                    MimView(video: video)
                        .overlay(alignment:.bottom,content: {
                            MimOverlayView(video: video)
                        })
                        .frame(width: 125,height: 125)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            }
        })
    }
}
#Preview {
    FavouriteView()
        .environmentObject(ContentViewModel())
}
