//
//  HomeView.swift
//  MimX
//
//  Created by Furkan Güryel on 21.10.2023.
//

import SwiftUI

struct HomeView: View {
    @State private var columns = Array(repeating: GridItem(), count: 3)
    @ObservedObject var vM = ContentViewModel()
    
    @State var videoUrl : String?
    var body: some View {
        LazyVGrid(columns: columns,spacing: 10, content: {
            ForEach(0...30,id: \.self){text in
                ZStack{
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .border(.blue,width: vM.isEditActive ? 3 : 0)
                }
                .onTapGesture {
                    if vM.isEditActive{
                        vM.editView.toggle()
                        vM.content = text
                    }
                }
            }
        })
        
    }
}

#Preview {
    HomeView(vM: ContentViewModel())
}
