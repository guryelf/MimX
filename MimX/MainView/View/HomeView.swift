//
//  HomeView.swift
//  MimX
//
//  Created by Furkan Güryel on 21.10.2023.
//
import Kingfisher
import SwiftUI

struct HomeView: View {
    @State private var columns = Array(repeating: GridItem(), count: 3)
    @ObservedObject var vM = ContentViewModel()
    @StateObject var mVM = MainViewModel()
    @State var videoUrl : String?
    var body: some View {
        LazyVGrid(columns: columns,spacing: 10, content: {
            ForEach(mVM.videos){video in
                Button(action: {
                    if vM.isEditActive{
                        vM.editView.toggle()
                    }
                }, label: {
                    KFImage(URL(string: video.thumbnail))
                        .resizable()
                        .frame(width: 30, height: 30)
                })
            }
        })
        
    }
}

#Preview {
    HomeView()
}
