//
//  HomeView.swift
//  MimX
//
//  Created by Furkan Güryel on 21.10.2023.
//
import Kingfisher
import SwiftUI
import AVKit

struct HomeView: View {
    @State private var columns = Array(repeating: GridItem(.fixed(125)), count: 3)
    @StateObject var vM = ContentViewModel()
    @StateObject var mVM = MainViewModel()
    var body: some View {
        LazyVGrid(columns: columns,spacing: 10, content: {
            ForEach(mVM.videos){video in
                MimView(video: video)
                    .frame(width: 125, height: 125)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
        })
    }
}

#Preview {
    HomeView()
}

