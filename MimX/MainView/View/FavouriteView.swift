//
//  FavouriteView.swift
//  MimX
//
//  Created by Furkan Güryel on 21.10.2023.
//

import SwiftUI

struct FavouriteView: View {
    @State private var columns = Array(repeating: GridItem(.fixed(125)), count: 3)
    @Environment(\.managedObjectContext) var moc
    private var videos : FetchedResults<VideoDB>?
    @StateObject var mVM = MainViewModel()
    @EnvironmentObject var vM : ContentViewModel
    var body: some View {
        LazyVGrid(columns: columns,spacing: 10, content: {
            if videos != nil{
                ForEach(videos!){video in
                    MimVideoView(videoURL: video.url!)
                }
            }
        })
    }
}
#Preview {
    FavouriteView()
}
